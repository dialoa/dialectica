class BlogPost < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user

  validates :title, presence: :true, uniqueness: true

  def self.category_options
    ["refeereing", "bibliography", "journals", "books", "OA"]
  end
end
