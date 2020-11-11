class User < ApplicationRecord
has_many :suggestion_submissions
has_many :reports
has_many :user_codes
has_many :codes, :through => :user_codes
has_many :submission_users
has_many :submissions, :through => :submission_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :user_roles
         has_many :roles, :through => :user_roles

   def name
     "#{self.firstname} #{self.lastname}"
   end
end
