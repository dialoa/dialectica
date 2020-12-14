class User < ApplicationRecord
has_many :suggestion_submissions
has_many :reports
has_many :user_codes
has_many :codes, :through => :user_codes
has_many :submission_users
has_many :submissions, :through => :submission_users
has_many :histories
has_many :blocked_users
has_many :blog_posts


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
         #, :validatable

         has_many :user_roles
         has_many :roles, :through => :user_roles

   def name
     "#{self.firstname} #{self.lastname}"
   end

 attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_h).first
    end
  end

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.notify_me_when_i_am_suggested_as_an_internal_referee_options
    ["no", "yes"]
  end

  def self.notify_me_when_something_happens_to_my_fish_options
    ["no", "yes"]
  end

  def self.send_notification
    User.where(notify_me_when_something_happens_to_my_fish: "yes").each do |user|
      SubmissionMailer.
    end
  end

end
