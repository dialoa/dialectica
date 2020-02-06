class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  #has_rich_text :content
  has_one_attached :cover

  before_save :update_search_field

  def update_search_field

    self.search_field =
    [
      title,
      description,
      keywords,
      #ActionView::Base.full_sanitizer.sanitize(content),
      ActionController::Base.helpers.strip_tags(content).squish,
      slug
    ].compact.join(' ')

  end
end
