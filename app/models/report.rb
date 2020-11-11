class Report < ApplicationRecord
  has_one_attached :file

  belongs_to :submission
  belongs_to :user
end
