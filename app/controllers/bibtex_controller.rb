require 'tempfile'

class BibtexController < ApplicationController

  def bibtex_enter

  end

  def bibtex_create
    text = params[:text]
    format = params[:format]

    CreateBibtexFileJob.perform_later(text, format)
    #bib = BibTeX::Bibliography.new
    #b = BibTeX.open('./public/bibtex/test.bib')
    #b['x'].title = "New Entry"
    #b.save
    #@results = []

    #if format == "bib"
    #  file = ""

    #  text.split("\n").each do |line|
    #    serrano = Serrano.works(query: line)
    #    file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)
        #@results.push(Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "text", style: "elsevier-harvard").force_encoding(Encoding::UTF_8))
        #next if serrano.nil?
        #byebug
        #Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"])
        #resultbib << Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)

        #file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)
        #file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "csl").force_encoding(Encoding::UTF_8)
        #file = file + "\n\n" + serrano["message"]["items"].first.to_s
        #####file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)
    #  end
    #  send_data file, filename: "references.bib"
    #elsif format == "json"
    #  json = []
    #  text.split("\n").each do |line|
    #    serrano = Serrano.works(query: line)
    #    json.push(serrano["message"]["items"].first)
    #  end

      #file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)
    #  send_data json.to_json, filename: "references.json"

    #elsif format == "citeproc-json"
    #  json = {"email" => "john@doe.com", "name" => "John Doe"}
    #  json = json.to_json
    #  text.split("\n").each do |line|
    #    serrano = Serrano.works(query: line)
        #json.push(serrano["message"]["items"].first)
    #    json = Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "json", style: "apa")
    #  end

      #file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)
    #  send_data json, filename: "citeproc.json"
    end


    #resultbib.close

    #resultbib = File.open("log.txt", "w") { |f| f.write "#{Time.now} - User logged in\n" }


    #@result = serrano["message"]["items"].first["DOI"]

    #send_data file, filename: "bib.bib"
  end
end
