require 'tempfile'

class BibtexController < ApplicationController

  def bibtex_enter

  end

  def compare_bibtex_with_crossref

    @result = ""

    if params[:text].present?
      text = params[:text]

      file_to_store = Tempfile.new('comparison')
      file_to_store.write(text)
      file_to_store.rewind

      b = BibTeX.open(file_to_store)

      b.each_with_index do |article, index|
        @result = @result + "@" + article.id + ", "
      end

      @result = @result[0..@result.size-3]

      file_to_store.close
    else

    end
    
  end

  def bibtex_comma_seperated_list_of_bibtex_keys

    @result = ""

    if params[:text].present?
      text = params[:text]

      file_to_store = Tempfile.new('comparison')
      file_to_store.write(text)
      file_to_store.rewind

      b = BibTeX.open(file_to_store)

      b.each_with_index do |article, index|
        @result = @result + "@" + article.id + ", "
      end

      @result = @result[0..@result.size-3]

      file_to_store.close
    else

    end


  end

  def bibtex_comma_seperated_list_of_bibtex_keys_output

  end

  def bibtex_create
    text = params[:text]
    format_string = params[:format_string]
    email = params[:email]

    #BibtexMailer.bibtex_is_finished_email(email, Stuff.first).deliver_now

    CreateBibtexFileJob.perform_later(text, format_string, email)

    redirect_to bibtex_enter_path, notice: 'File is being produced! Wait for the mail.'
  end

  def bibtex_create_fast
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
