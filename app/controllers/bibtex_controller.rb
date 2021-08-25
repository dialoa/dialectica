require 'tempfile'
require 'fuzzystringmatch'
require 'net/http'
require 'json_converter'

class BibtexController < ApplicationController

  def get_bib_from_biblio

    @found = ""
    @not_found = ""
    @result = ""

    if params[:text].present?
      text = params[:text]

      file_to_store = Tempfile.new('comparison')
      #file_to_store.write(text)
      file_to_store.write(text.squish)
      file_to_store.rewind

      File.open("#{Rails.root}/dialectica/biblio.bib") do |f|
        f.each_line do |line|
          if line =~ /rowland_c:2008/
            puts "Found line: #{line}"
            @result =+ line
          end
        end
      end

      #b = BibTeX.open("#{Rails.root}/dialectica/biblio.bib")
      #text.split("\n").each do |line|
      #  next if line.blank?
      #  byebug
      #end


      file_to_store.close
    else

    end

  end

  def compare_author_bibtex_with_crossref_create

    email = params[:email]
    format = params[:format]
    file = params[:file]

    if file.present?
      text = file.read
    else
      text = params[:text]
    end

    CompareAuthorBibtexWithCrossrefJob.perform_later(text, email, format)

    redirect_to bibtex_compare_author_bibtex_with_crossref_path, notice: 'Wait for the mail!'
  end

  def compare_author_bibtex_with_crossref

  end

  def compare_author_bibtex_with_crossref_select
    array_of_originals = params[:array_of_originals]
    @format_type = params[:format_type]
    array_of_originals.split(',')

    if @format_type == "json"
      @array_of_originals = Json.where(id: array_of_originals.split(','))
    else
      @array_of_originals = BibtexEntry.where(id: array_of_originals.split(','))
    end

  end

  def bibtex_enter

  end

  def compare_author_bibtex_with_crossref_json

  end

  def compare_bibtex_with_crossref

    @result = []

    if params[:text].present?
      text = params[:text]

      cp = CiteProc::Processor.new style: 'apa', format: 'text'

      file_to_store = Tempfile.new('comparison')
      file_to_store.write(text)
      file_to_store.rewind

      b = BibTeX.open(file_to_store)
      cp.import BibTeX.open(file_to_store).to_citeproc

      b.each_with_index do |article, index|
        result_from_bibtex = (cp.render :bibliography, id: article.id).first
        result_from_crossref = ""

        if article.try(:doi).nil? || article.doi.blank?
          serrano = Serrano.works(query: result_from_bibtex)
          result_from_crossref = + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "text", style: "apa").force_encoding(Encoding::UTF_8)
        else
          result_from_crossref = Serrano.content_negotiation(ids: article.doi, style: "apa", format: "text").force_encoding(Encoding::UTF_8)
        end

        #serrano = Serrano.works(query: line)
        #result_from_crossref = Serrano.content_negotiation(ids: article.doi, style: "apa", format: "text").force_encoding(Encoding::UTF_8)

        @result.push([result_from_bibtex, result_from_crossref])
      end


      file_to_store.close
    else


    end

  end

  def bibtex_comma_seperated_list_of_bibtex_keys

    @result = ""
    @result2 = ""

    if params[:text].present?
      text = params[:text]

      file_to_store = Tempfile.new('comparison')
      #file_to_store.write(text)
      file_to_store.write(text.squish)
      file_to_store.rewind

      b = BibTeX.open(file_to_store)

      b.each_with_index do |article, index|
        @result = @result + "@" + article.id + ", "
        @result2 = @result2 + "@" + article.id + "\n"
      end

      @result = @result[0..@result.size-3]

      file_to_store.close
    else

    end


  end

  def bibtex_comma_seperated_list_of_bibtex_keys_output

  end

  def replace_underscore


    #send_file '/path/to.jpeg', :type => 'image/jpeg', :disposition => 'inline'
  end

  def replace_underscore_forwards
    file = params[:replace_file][:replace_file]
    filename = file.original_filename
    text = file.read
    text = change_underscore_in_bibtex_key(text, '_', '---::---')
    send_data text, filename: "#{filename.split('.').first}_underscore_replaced.bib"
  end

  def replace_underscore_backwards
    file = params[:replace_file][:replace_file]
    filename = file.original_filename
    text = file.read
    text = change_underscore_in_bibtex_key(text, '---::---', '_')
    send_data text, filename: "#{filename.split('.').first}_underscored.bib"
  end

  def squish_bibtex_file

  end

  def get_dialectica_articles_from_crossref
    #issn = "1746-8361"
    #serrano = Serrano.works(query_container_title: "dialectica")
    #serrano = Serrano.works(query: "", filter: { container_title: "Dialectica" })
    #@result = serrano

    #source = 'https://api.crossref.org/works?filter=issn:1746-8361&rows=1000&mailto=sandro.raess@philosophie.ch'
    #resp = Net::HTTP.get_response(URI.parse(source))
    #data = resp.body
    #@result = JSON.parse(data)

    #@result_items = @result["message"]["items"]

    #first_json = get_json_from_crossref('https://api.crossref.org/works?filter=issn:1746-8361&rows=1000&mailto=sandro.raess@philosophie.ch')
    #second_json = get_json_from_crossref('https://api.crossref.org/works?filter=issn:1746-8361&rows=1000&offset=1000&mailto=sandro.raess@philosophie.ch')
    #third_json = get_json_from_crossref('https://api.crossref.org/works?filter=issn:1746-8361&rows=1000&mailto=sandro.raess@philosophie.ch')

    #first_json = get_json_from_crossref('https://api.crossref.org/works?filter=issn:0012-2017&rows=1000&mailto=sandro.raess@philosophie.ch')
    #second_json = get_json_from_crossref('https://api.crossref.org/works?filter=issn:0012-2017&rows=1000&offset=1000&mailto=sandro.raess@philosophie.ch')
    #third_json = get_json_from_crossref('https://api.crossref.org/works?filter=issn:0012-2017&rows=1000&offset=2000&mailto=sandro.raess@philosophie.ch')

    rows = "&rows=1000"
    mailto = "&mailto=sandro.raess@philosophie.ch"
    source = "https://api.crossref.org/works?filter=issn:0031-8116"
    offset = "&offset="
    resp = Net::HTTP.get_response(URI.parse(source + rows + mailto))
    data = resp.body
    result = JSON.parse(data)
    result_items = result["message"]["items"]

    total_results = result["message"]["total-results"]
    (total_results / 1000).times do |index|
      result_items = result_items + get_json_from_crossref(source + rows + offset + "#{(index + 1)*1000}" + mailto)
    end

    @result_items = result_items

    attributes = %w{author year title doi}
    csv = CSV.generate(headers: true) do |csv|
      csv << attributes

      @result_items.each do |item|
        author = ""
        if !item["author"].blank?
          item["author"].each_with_index do |name, index|
            author = author + "#{name["given"]} #{name["family"]}"
            unless index == item["author"].size - 1
              author = author + ", "
            end
          end
        end

        year = ""
        if !item["published-print"].blank?
          year = item["published-print"]["date-parts"][0][0]
        end

        title = ""
        if !item["title"].blank?
          title = item["title"][0]
        end


        item_array = [
          author,
          year,
          title,
          item["DOI"]
        ]
        csv << item_array
      end
    end

    send_data csv, filename: "dialectica-on-crossref.csv"
    #converter = JsonConverter.new

    #json = @result

    #csv = converter.generate_csv(json)               # Generate a CSV string...
    #converter.write_to_csv(json, 'boiled_frogs.csv') # ... or write your CSV to a file

  end

  def squish_bibtex_file_execute
    file = params[:bibtex][:file]
    filename = file.original_filename
    bibtex_text = file.read

    bobba = BibTeX.parse(bibtex_text)
    bibtex_text_squished = ""

    bobba.each_with_index do |article, index|
      #article.id = id_of_author_bibtex
      #byebug
      bibtex_text_squished = bibtex_text_squished + article.to_s.squish + "\n" unless article.blank?
    end
    send_data bibtex_text_squished, filename: "#{filename.split('.').first}_squished.bib"
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

  def change_id_of_bibtex_entry(id_of_author_bibtex, new_bibtex_file)
    bobba = BibTeX.parse(new_bibtex_file)
    article_text = ""

    bobba.each_with_index do |article, index|
      article.id = id_of_author_bibtex
      article_text = article
    end

    article_text
  end

  def change_underscore_in_bibtex_key(bibtex_code, expression_to_replace, expression_that_replaces)
    bobba = BibTeX.parse(bibtex_code)

    bobba.each_with_index do |article, index|
      article.id = article.id.gsub(expression_to_replace, expression_that_replaces)
    end
    #bobba.save
    bobba
  end

  private

  def get_json_from_crossref(url)
    source = url
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    result = JSON.parse(data)

    result_items = result["message"]["items"]
  end

end
