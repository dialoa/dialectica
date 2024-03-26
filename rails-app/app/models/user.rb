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


scope :not_hidden, -> { where(hidden: "no") }
scope :admins, -> { joins(:roles).where('roles.name = ?', "admin") }
scope :editors, -> { joins(:roles).where('roles.name = ?', "editor") }
scope :reviewers, -> { joins(:roles).where('roles.name = ?', "reviewer") }
scope :authors, -> { joins(:roles).where('roles.name = ?', "author") }

scope :available_for_internal_review, -> { admins.or(self.editors).or(self.reviewers).distinct }


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

   def self.hidden_options
     ["yes", "no"]
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
  #validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username

  def self.create_uniq_username(lastname)
    new_username = lastname
    number = 1
    while User.where(username: new_username).exists?
      new_username = new_username + number.to_s
      number = number + 1
    end
    new_username
  end

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

  def self.placeholders(user = nil)
    {
      "user.firstname": user && user.firstname ? user.firstname : "John",
      "user.lastname": user && user.lastname ? user.lastname : "Smith",
      "user.email": user && user.email ? user.email : "john.smith@gmail.com",
      "user.username": user && user.username ? user.username : "john.smith"
    }
  end

  def self.send_notifications
    #byebug
    subject = "dialectica - report"
    #byebug
    User.where(notify_me_when_something_happens_to_my_fish: "yes").each do |user|

body = ""
      user.submissions.each do |submission|
        histories_today = submission.histories.where(created_at: DateTime.now-1.day..DateTime.now)
        #byebug
        unless histories_today.empty?
          body = body + "##{submission.id} - #{submission.title} \n\n"
          histories_today.each do |history|
            body = body + "#{history.user.name} #{I18n.l history.created_at, format: :usa} \n"
            body = body + "#{ActionController::Base.helpers.strip_tags history.content} \n \n"
          end
        end
      end

      unless body.blank?
        body = body.prepend("dialectica - report \n\n")
        SubmissionMailer.send_notifications_of_what_happened_today(user, subject, body).deliver_now
      end

    end
  end

end
