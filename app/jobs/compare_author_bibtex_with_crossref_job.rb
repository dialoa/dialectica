class CompareAuthorBibtexWithCrossrefJob < ApplicationJob
  queue_as :default

  def perform(text, email)
    #@array_of_bibtex_originals = []
    @array_of_bibtex_originals = ""

    #@result = []

      #cp = CiteProc::Processor.new style: 'apa', format: 'text'

      file_to_store = Tempfile.new('comparison')
      file_to_store.write(text)
      file_to_store.rewind

      b = BibTeX.open(file_to_store)
      #cp.import BibTeX.open(file_to_store).to_citeproc

      #every article in the author's bibtex file gets scanned
      b.each_with_index do |article, index|
        #result_from_bibtex = (cp.render :bibliography, id: article.id).first
        result_from_bibtex = article
        bibtex_entry_of_author = BibtexEntry.create(content: result_from_bibtex)

        result_from_crossref = ""

        #check if doi is available
        #if article.try(:doi).nil? || article.doi.blank?
        begin
          serrano = Serrano.works(query: result_from_bibtex)

          serrano["message"]["items"].first(10).each do |item|
            begin
              result_from_crossref = Serrano.content_negotiation(ids: item["DOI"], format: "text", style: "bibtex").force_encoding(Encoding::UTF_8)
              result_from_crossref = change_id_of_bibtex_entry(article.id, result_from_crossref)
              bibtex_entry_of_author.children.create(content: result_from_crossref.to_s.strip)
            rescue
              @retries ||= 0
              if @retries < 3
                @retries += 1
                puts "ERROR!!! RETRY: #{@retries}"
                sleep 3
                retry
              end
            end

          end
        rescue
          @retries ||= 0
          if @retries < 3
            @retries += 1
            puts "ERROR!!! RETRY: #{@retries}"
            sleep 500
            retry
          else
            #file = file + "ERROR for: #{line}"
          end
        end
          #serrano = Serrano.works(query: result_from_bibtex)
          #result_from_crossref = + Serrano.content_negotiation(ids: serrano["message"]["items"].first["DOI"], format: "text", style: "apa").force_encoding(Encoding::UTF_8)

        #else
        #  result_from_crossref = Serrano.content_negotiation(ids: article.doi, style: "apa", format: "text").force_encoding(Encoding::UTF_8)
        #
        #  result_from_crossref = change_id_of_bibtex_entry(article.id, result_from_crossref)
        #
        #  bibtex_entry_of_author.children.create(content: result_from_crossref.to_s.strip)
        #end

        #serrano["message"]["items"].first(10).each do |item|
        #  BibtexEntry.create(content: Serrano.content_negotiation(ids: item["DOI"], format: "text", style: "apa").force_encoding(Encoding::UTF_8))
        #end

        #serrano = Serrano.works(query: line)
        #result_from_crossref = Serrano.content_negotiation(ids: article.doi, style: "apa", format: "text").force_encoding(Encoding::UTF_8)

        #@result.push([result_from_bibtex, result_from_crossref])
        #@array_of_bibtex_originals.push(bibtex_entry_of_author)
        @array_of_bibtex_originals = @array_of_bibtex_originals + ", #{bibtex_entry_of_author.id}"
      end


      file_to_store.close

      BibtexMailer.bibtex_is_ready_to_compare_email(@array_of_bibtex_originals, email).deliver_now
  end

  def change_id_of_bibtex_entry(id_of_author_bibtex, new_bibtex_file)

    file_to_store = Tempfile.new('comparison')
    file_to_store.write(new_bibtex_file)
    file_to_store.rewind

    bobba = BibTeX.open(file_to_store)
    #bobba = BibTeX.parse(new_bibtex_file)
    article_text = ""

    bobba.each_with_index do |article, index|
      article.id = id_of_author_bibtex
      article_text = article
    end

    file_to_store.close
    article_text
  end
end
