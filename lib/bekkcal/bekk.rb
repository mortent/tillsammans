require 'net/http'
require 'net/https'
require 'cgi'
require 'time'
require 'rubygems'
require 'vpim/icalendar'
require 'json'

# Original code by Aslak Hellesøy
module Bekkcal
  class Notes
    attr_reader :username
    def initialize(host, username, password)
      @host, @username, @password = host, username, password
    end
    
    # Logs in by storing a session cookie and the logged in user's
    # database URL. Returns true for successful login.
    def login
      return false if @username.nil? || @password.nil?
      @http = Net::HTTP.new(@host, 443)
      @http.use_ssl = true
      fields = "username=#{CGI::escape(@username)}&password=#{CGI::escape(@password)}&redirectto=%2Fwebmailr.nsf%3FOpen"
      resp = @http.request_post('/names.nsf?Login', fields)
      if resp.code == '302' && resp['Location'] =~ /webmailr\.nsf\?Open/
        # Successful login.
        cookie = resp['set-cookie']
        @headers = {'Cookie' => cookie}
        
        r = @http.request_get(resp['Location'], @headers)
        if r.body =~ /URL=https:\/\/#{@host}([^"]*)/m
          @db_url = $1
          true
        else
          # Login failed, but we didn't find the personal database URL, so we'll say
          # login failed.
          false
        end
      else
        # Failed login
        # The code is 200. The IBM iNotes team doesn't understand HTTP.
        false
      end
    end

    # Creates an iCal for a personal nsf file +db+, between the Time +from+ and +to+
    # http://www.ibm.com/developerworks/lotus/library/ls-XML_iNotes/index.html
    def personal(from=nil, to=nil)
      today = Time.now.midnight
      from ||= today.plus_day(-30)
      to   ||= today.plus_day(365)
      
      login
      path = "#{@db_url}/iNotes/Proxy/?OpenDocument&Form=s_ReadViewEntries&PresetFields=FolderName;($Calendar),noPI;1,s_UsingHttps;1,hc;$151&KeyType=time&StartKey=#{from.notes}&UntilKey=#{to.notes}&Count=-1&TZType=UTC&OutputFormat=JSON"
      resp = @http.request_get(path, @headers)
      ical(resp.body, NotesCalendar.new)
    end
    
    def bekk
      # To tweak count: &Count=9000
      path = "/mail/kalender.nsf/BekkMeetings?ReadViewEntries&OutputFormat=JSON"
      resp = @http.request_get(path, @headers)
      ical(resp.body, BekkCalendar.new)
    end
    
    def ical(json, parser)
      struct = JSON.parse(json)

      cal = Vpim::Icalendar.create2
      struct['viewentry'].each do |viewentry|
        add_event(cal, viewentry['entrydata'], parser)
      end
      cal.encode(0)
    end

    def add_event(cal, entrydata, parser)
      cal.add_event do |e|
        begin
          # Mandatory fields
          e.summary(parser.summary(entrydata))
          e.dtstart(parser.dtstart(entrydata))

          # Optional fields
          dtend       = parser.dtend(entrydata);       e.dtend(dtend)                   unless dtend.nil?
          status      = parser.status(entrydata);      e.set_text('STATUS', status)     unless status.nil?
          location    = parser.location(entrydata);    e.set_text('LOCATION', location) unless location.blank?
          description = parser.description(entrydata); e.description(description)       unless description.blank?
          organizer   = parser.organizer(entrydata)  
          unless organizer.blank?
            e.organizer(Vpim::Icalendar::Address.create(organizer))
          end
        rescue => e
          puts e.message
          puts e.backtrace.join("\n")
          puts "+++++ JSON WAS +++++"
          puts JSON.pretty_generate(entrydata)
        end
      end
    end
  end

  class NotesCalendar
    def summary(entrydata)
      entrydata.name('$151')['text']['0'] rescue entrydata.name('$151')['textlist']['text'][0]['0']
    end
    
    def status(entrydata)
      # It's not in the JSON I think.
    end

    def dtstart(entrydata)
      time = entrydata.name('$134')['datetime']['0'] rescue entrydata.name('$134')['datetimelist']['datetime'][0]['0']
      tim2 = entrydata.name('$144')['datetime']['0'] rescue entrydata.name('$144')['datetimelist']['datetime'][0]['0'] rescue nil
      
      # Although IBM's format is undocumented on the Internet, it seems like for regular events, these two
      # times are identical, and for all-day events it's not set. It's just a guess though.
      t = Time.parse(time).utc
      if time != tim2
        t = t.getlocal.send :to_datetime
      end
      t
    end

    def dtend(entrydata)
      time_entry = entrydata.name('$146')
      if time_entry # Some events don't have an end (whole day)
        time = time_entry['datetime']['0'] rescue time_entry['datetimelist']['datetime'][0]['0'] rescue nil
        time.blank? ? nil : Time.parse(time).utc
      else
        nil
      end
    end

    def location(entrydata)
      entrydata.name('$151')['textlist']['text'][1]['0'] \
      .gsub(/Room: (.*)\/Oslo@Bekk/, '\1') \
      .gsub(/Location: (.*)/, '\1').strip rescue nil
    end

    def description(entrydata)
      # It's not in the JSON. Maybe we need to some extra params in the URL to get it?
    end

    def organizer(entrydata)
      entrydata.name('$151')['textlist']['text'][2]['0'].gsub(/Chair: (.*)/, '\1') rescue nil
    end
  end

  class BekkCalendar
    def summary(entrydata)
      # Det ser ut som dobbeltbooking via FYI (bcc) gir "Invitation: " som prefix (!!??)
      # Det er helt ok, men vi stripper det bort...
      raw_summary(entrydata).gsub(/^Accepted: (.*)/, '\1').gsub(/^Invitation: (.*)/, '\1').gsub(/^Declined: (.*)/, '\1')
    end
    
    def status(entrydata)
      raw_summary(entrydata).match(/^Declined: /) ? 'CANCELLED' : nil
    end

    def dtstart(entrydata)
      datetime = entrydata.name('StartDateTime')['datetime'] || entrydata.name('StartDateTime')['datetimelist']['datetime'][0]
      Time.parse(datetime['0']).utc
    end

    def dtend(entrydata)
      datetime = entrydata.name('EndDateTime')['datetime'] || entrydata.name('EndDateTime')['datetimelist']['datetime'][0]
      Time.parse(datetime['0']).utc
    end

    def location(entrydata)
      loc  = entrydata.name('Location')['text']['0'] rescue nil
      room = entrydata.name('Room')['text']['0'] rescue nil
      [loc, room].compact.join(" ").gsub(/(.*)\/Oslo@Bekk/, '\1').strip
    end

    def description(entrydata)
      entrydata.name('BodyText')['text']['0']
    end

    def organizer(entrydata)
      entrydata.name('Chair')['text']['0'].gsub(/CN=(.*)\/O=Bekk/, '\1') rescue nil
    end
  
  protected
  
    def raw_summary(entrydata)
      entrydata.name('Topic')['text']['0']
    end
  end
end
