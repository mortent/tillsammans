require 'digest/sha1'
class User < ActiveRecord::Base  
  belongs_to :location
  has_many :attendances
  has_many :events, :through => :attendances
    
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 2..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
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
