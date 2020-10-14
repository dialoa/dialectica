class CompareBibtexWithCrossrefJob < ApplicationJob
  queue_as :default

  def perform(text, email)
    array_of_bibtex_entries = []

    file_to_store = Tempfile.new('references-#{Date.today.to_s}.json')
    file_to_store.write(text)
    file_to_store.rewind

    b = BibTeX.open(file_to_store)

    b.each_with_index do |article, index|
      @result = @result + "@" + article.id + ", "
      cp = CiteProc.process b[article.id].to_citeproc, :style => :apa
      byebug
    end

    @result = @result[0..@result.size-3]

    file_to_store.close
    # Do something later
  end
end
