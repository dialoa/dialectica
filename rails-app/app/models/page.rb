class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  #has_rich_text :content
  has_one_attached :cover

  validates :slug, :title, presence: true, uniqueness: true

  before_save :update_search_field
  after_create :set_sort

  def self.status_options
    ["visible", "hidden"]
  end

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

  private

  def set_sort
    highest_value = Page.order(:sort).last.sort
    self.update(sort: highest_value + 1)
  end

end
