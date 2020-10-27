class Code < ApplicationRecord
has_many :user_codes
has_many :users, :through => :user_codes
end
