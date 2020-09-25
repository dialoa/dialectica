class CreateBibtexFileJob < ApplicationJob
  queue_as :default

  def perform(text, format)
    if format == "bib"
      file = ""
      text.split("\n").each do |line|
        next if line.blank?
          begin
            serrano = Serrano.works(query: line)
            file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)
          rescue
            @retries ||= 0
            if @retries < 3
              @retries += 1
              puts "ERROR!!! RETRY: #{@retries}"
              sleep 300
              retry
            else
              file = file + "ERROR for: #{line}"
            end
          end
      end
      file_to_store = Tempfile.new('references-#{Date.today.to_s}.bib')
      file_to_store.write(file)
      stuff = Stuff.create(filename: "references-#{Date.today.to_s}")
      file_to_store.rewind
      stuff.file.attach(io: file_to_store, filename: "references-#{Date.today.to_s}.bib")
      file_to_store.close


    elsif format == "json"
      json = []
      text.split("\n").each do |line|
        next if line.blank?

          begin
            serrano = Serrano.works(query: line)
            json.push(serrano["message"]["items"].first)
          rescue
            @retries ||= 0
            if @retries < 3
              @retries += 1
              puts "ERROR!!! RETRY: #{@retries}"
              sleep 300
              retry
            else
              json.push("ERROR for: #{line}")
            end
          end


      end

      file_to_store = "references.json"
      Tempfile.open(file_to_store, "w"){|f| f << json.to_json}

      stuff = Stuff.create(filename: "references-#{Date.today.to_s}")
      stuff.file.attach(file_to_store)
    end
  end
end
