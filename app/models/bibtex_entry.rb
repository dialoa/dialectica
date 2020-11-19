class BibtexEntry < ApplicationRecord
  belongs_to :bibtex_file, optional: true
  has_ancestry

  has_many :jsons
end
