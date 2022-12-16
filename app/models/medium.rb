class Medium < ApplicationRecord
  has_one_attached :file
  belongs_to :mediumable, polymorphic: true

  validates :file, attached: true, size: { less_than: 3.megabytes , message: 'is too large' }

end
