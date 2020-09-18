class Stuff < ApplicationRecord
  has_one_attached :file

  def self.pandoc_options
    ["docx", "odt", "markdown", "latex", "html"]
  end

  def self.bibtex_options
    ["bib", "json"]
  end

  def self.get_extension(option)
    extensions = {
      "docx" => "docx",
      "odt" => "odt",
      "markdown" => "md",
      "latex" => "tex",
      "html" => "html"
    }

    return extensions[option]
  end

end
