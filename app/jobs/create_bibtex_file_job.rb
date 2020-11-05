class CreateBibtexFileJob < ApplicationJob
  queue_as :default

  def perform(text, format, email)
    stuff = Stuff.create(filename: "references-#{Time.now.strftime("%d/%m/%Y %H:%M")}")

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
      file_to_store.rewind
      stuff.file.attach(io: file_to_store, filename: "references-#{Date.today.to_s}.bib")
      file_to_store.close


    elsif format == "json"
      json = []
      text.split("\n").each do |line|
        next if line.blank?

          begin
            serrano = Serrano.works(query: line)
            result_from_serrano = Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "citeproc-json")
            json.push(result_from_serrano)
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

      file_to_store = Tempfile.new('references-#{Date.today.to_s}.json')
      file_to_store.write(json.to_json)
      file_to_store.rewind
      stuff.file.attach(io: file_to_store, filename: "references-#{Date.today.to_s}.json")
      file_to_store.close
    end

    BibtexMailer.bibtex_is_finished_email(email, stuff).deliver_now
  end
end
