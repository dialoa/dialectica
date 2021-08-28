class Article < ApplicationRecord

  belongs_to :issue, optional: true

  def self.formats
    #xml: DocBook, TEI simple
    #rtf: Rich Text Format
    #plain: Plain Text
    #odt: Open Office Libre Office
    ["html", "latex", "markdown", "odt", "docbook", "rtf", "pdf", "plain"]
  end

  def self.statuses
    ["submitted", "published"]
  end

  def self.phases
    #["submitted", "published"]
    [
      "author submits article",
      "editor assesses article",
      "article sent to reviewers",
      "editor assesses reviews",
      "article is accepted",
      "article is in production",
      "article is published"
    ]
  end

   scope :submitted, -> { where(status: "submitted") }

   def peer_review_process

   {
     "content": "Author submits Article",
     "children": [
     ]
   }
   end

end
