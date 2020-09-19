class CreateBibtexFileJob < ApplicationJob
  queue_as :default

  def perform(text, format)
    if format == "bib"
      file = ""
      text.split("\n").each do |line|
        serrano = Serrano.works(query: line)
        file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)
        sleep 1
      end

      #send_data file, filename: "references.bib"
      #file = create_data file, filename: "references.bib"
      #file_to_store = "references.bib"
      file_to_store = Tempfile.new("references.bib", "w"){|f| f << file}

      stuff = Stuff.create(filename: "references-#{Date.today.to_s}")
      stuff.file.attach(file_to_store)

    elsif format == "json"
      json = []
      text.split("\n").each do |line|
        serrano = Serrano.works(query: line)
        json.push(serrano["message"]["items"].first)
        sleep 1
      end
      #send_data json.to_json, filename: "references.json"
      file_to_store = "references.json"
      Tempfile.open(file_to_store, "w"){|f| f << json.to_json}

      stuff = Stuff.create(filename: "references-#{Date.today.to_s}")
      stuff.file.attach(file_to_store)
    end
  end
end
