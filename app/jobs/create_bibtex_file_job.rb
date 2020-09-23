class CreateBibtexFileJob < ApplicationJob
  queue_as :default

  def perform(text, format)
    if format == "bib"
      file = ""
      text.split("\n").each do |line|
        sleep 1
        next if line.blank?
        serrano = Serrano.works(query: line)
        file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)

      end

      #send_data file, filename: "references.bib"
      #file = create_data file, filename: "references.bib"
      #file_to_store = "references.bib"
      #file_to_store = Tempfile.new("references.bib", "w"){|f| f << file}
      file_to_store = Tempfile.new('references-#{Date.today.to_s}.bib')
      file_to_store.write(file)


      stuff = Stuff.create(filename: "references-#{Date.today.to_s}")
      #stuff.file.attach(file_to_store)
      file_to_store.rewind

      stuff.file.attach(io: file_to_store, filename: "references-#{Date.today.to_s}.bib")
      file_to_store.close


    elsif format == "json"
      json = []
      text.split("\n").each do |line|
        sleep 1
        next if line.blank?
        serrano = Serrano.works(query: line)
        json.push(serrano["message"]["items"].first)
      end
      #send_data json.to_json, filename: "references.json"
      file_to_store = "references.json"
      Tempfile.open(file_to_store, "w"){|f| f << json.to_json}

      stuff = Stuff.create(filename: "references-#{Date.today.to_s}")
      stuff.file.attach(file_to_store)
    end
  end
end
