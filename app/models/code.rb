class Code < ApplicationRecord
has_many :user_codes
has_many :users, :through => :user_codes
has_one :bibtex_file

  def self.template_options
    ["galley", "proof"]
  end
end
