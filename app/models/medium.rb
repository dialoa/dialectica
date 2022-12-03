class Medium < ApplicationRecord
  has_one_attached :file
  belongs_to :mediumable, polymorphic: true


end
