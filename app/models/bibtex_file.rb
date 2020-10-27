class BibtexFile < ApplicationRecord
  has_many :bibtex_entries
  belongs_to :code
end
