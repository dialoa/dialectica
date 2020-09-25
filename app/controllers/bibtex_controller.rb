require 'tempfile'

class BibtexController < ApplicationController

  def bibtex_enter

  end

  def bibtex_create_later
    text = params[:text]
    format = params[:format]

    CreateBibtexFileJob.perform_later(text, format)
  end

  def bibtex_create
    text = params[:text]
    format = params[:format]

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
        #serrano = Serrano.works(query: line)

        #file = file + "\n\n" + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "bibtex").force_encoding(Encoding::UTF_8)

      end

      send_data file, filename: "references.bib"

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
      send_data json.to_json, filename: "references.json"
    end
  end


end
