class BibtexController < ApplicationController

  def bibtex_enter

  end

  def bibtex_create
    #b = BibTeX.open('./public/bibtex/test.bib')
    #b['x'].title = "New Entry"
    #b.save
    bib = BibTeX::Bibliography.new
    bib << BibTeX::Entry.new({
      :bibtex_type => :book,
      :key => :rails,
      :address => 'Raleigh, North Carolina',
      :author => 'Ruby, Sam and Thomas, Dave, and Hansson, David Heinemeier',
      :booktitle => 'Agile Web Development with Rails',
      :edition => 'third',
      :keywords => 'ruby, rails',
      :publisher => 'The Pragmatic Bookshelf',
      :series => 'The Facets of Ruby',
      :title => 'Agile Web Development with Rails',
      :year => '2009'
    })
    send_data bib, filename: "biblixy.bib"
  end
end
