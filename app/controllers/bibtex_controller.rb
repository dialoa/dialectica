class BibtexController < ApplicationController

  def bibtex_enter

  end

  def bibtex_create
    text = params[:text]
    #b = BibTeX.open('./public/bibtex/test.bib')
    #b['x'].title = "New Entry"
    #b.save
    @results = []

    text.split("\n").each do |line|
      serrano = Serrano.works(query: text)
      next if serrano.nil?
      @results.push(Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "text", style: "elsevier-harvard").force_encoding(Encoding::UTF_8))
    end



    #@result = serrano["message"]["items"].first["DOI"]


    #send_data bib, filename: "biblixy.bib"
  end
end
