class BlockedUser < ApplicationRecord
  belongs_to :submission
  belongs_to :user
end
