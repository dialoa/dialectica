class History < ApplicationRecord
  belongs_to :user
  belongs_to :submission

  scope :ilike_search_field, ->(search_term) { where("search_field ILIKE ?", "%#{search_term}%") }

  before_save :update_search_field

  private

  def update_search_field

    self.search_field =
    [
      id,
      ActionController::Base.helpers.strip_tags(self.content)
    ].compact.join(' ')

  end


end
