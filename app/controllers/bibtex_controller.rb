class BibtexController < ApplicationController

  def bibtex_enter

  end

  def bibtex_create
    text = params[:text]
    #b = BibTeX.open('./public/bibtex/test.bib')
    #b['x'].title = "New Entry"
    #b.save

    serrano = Serrano.works(query: text)

    #@result = serrano["message"]["items"].first["DOI"]
    @result = Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "text", style: "elsevier-harvard").force_encoding(Encoding::UTF_8)

    #send_data bib, filename: "biblixy.bib"
  end
end
