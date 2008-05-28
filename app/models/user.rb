require 'digest/sha1'
class User < ActiveRecord::Base  
  belongs_to :location
  has_many :attendances
  has_many :passengers
  has_many :events, :through => :attendances

  validates_presence_of     :login, :email
  validates_length_of       :login,    :within => 2..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    employee_id = Employee.authenticate(login,password)
    return nil unless employee_id
    user = User.find_by_bekk_id(employee_id)
    user || add_user(employee_id)
  end
  
  def self.add_user(bekk_id)
    employee = Employee.find(bekk_id)
    user = User.new
    user.login = employee.LogonID
    user.email = employee.employee_info.Email
    user.bekk_id = bekk_id
    user.save ? user : nil  
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end
  
  def to_gmarker
    icon = GIcon.new(:image => '/images/ikon_bekker.png', :icon_size => GSize.new( 24,32 ), 
            :icon_anchor => GPoint.new(16,16), :info_window_anchor => GPoint.new(16,16))     
    GMarker.new([location.lat, location.lng], :title => login, :icon => icon, 
            :info_window => "<b>#{login}</b><br/>#{email}<br>")  
  end   
  
  def update_from_personal_bekk_calendar
    host = 'hugin.bekk.no'
    ics = Bekkcal::Reader.personal(host, mail_username, mail_password)
    if ics
      cal = Vpim::Icalendar.decode(ics).first.components do |ical_event|
        next if ical_event.summary.nil? || ical_event.summary.strip == ""
        
        puts "-----------------------"
        event_name = ical_event.summary
        puts event_name
        
        event = Event.find_by_name(event_name)

        if event.nil?
          event = Event.create!(:name => ical_event.summary, :description => ical_event.description || "", :starts_at => ical_event.dtstart, :ends_at => ical_event.dtend, :location => Location.find_by_name("BEKK"))
        end
        
        attendance = Attendance.new(:event => event, :user => self)
        event.attendances << attendance
        event.save!
      end      
    end
  end
  
  
  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
        
end
