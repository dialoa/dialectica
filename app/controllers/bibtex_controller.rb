require 'tempfile'

class BibtexController < ApplicationController

  def bibtex_enter

  end

  def bibtex_create
    text = params[:text]
    #bib = BibTeX::Bibliography.new
    #b = BibTeX.open('./public/bibtex/test.bib')
    #b['x'].title = "New Entry"
    #b.save
    @results = []
    file = ""


    text.split("\n").each do |line|
      serrano = Serrano.works(query: text)

      #@results.push(Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "text", style: "elsevier-harvard").force_encoding(Encoding::UTF_8))
      #next if serrano.nil?
      #byebug
      #Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"])
      #resultbib << Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)

      file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)
      #####file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)
    end

    #resultbib.close

    #resultbib = File.open("log.txt", "w") { |f| f.write "#{Time.now} - User logged in\n" }


    #@result = serrano["message"]["items"].first["DOI"]

    send_data file, filename: "bib.bib"
  end
end
