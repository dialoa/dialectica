class Article < ApplicationRecord

  belongs_to :issue, optional: true

  def self.formats
    #xml: DocBook, TEI simple
    #rtf: Rich Text Format
    #plain: Plain Text
    #odt: Open Office Libre Office
    ["html", "latex", "markdown", "odt", "docbook", "rtf", "pdf", "plain"]
  end

end
