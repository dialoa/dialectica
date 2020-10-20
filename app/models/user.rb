class User < ApplicationRecord
has_many :submission_users
has_many :submissions, :through => :submission_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :user_roles
         has_many :roles, :through => :user_roles
end
