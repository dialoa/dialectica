class BlogPost < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.category_options
    ["refeereing", "bibliography", "journals", "books", "OA"]
  end
end
