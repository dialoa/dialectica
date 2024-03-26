class Json < ApplicationRecord
  has_ancestry
  belongs_to :bibtex_entry, optional: true
end
