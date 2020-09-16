class PandocController < ApplicationController
  def pandoc
    #file = params[:file]
    #@file_content = file.read unless file.nil?
    #utf8_string = @file_content.encode('utf-8')
    #@converted_text = Iconv.conv('utf-8', "ascii", @file_content)

    #@converter = PandocRuby.new(@file_content, from: :docx, to: :html).convert unless @file_content.nil?
    #@converted = PandocRuby.new(file.read, from: 'docx').to_html.convert unless file.nil?
    #@converted = PandocRuby.new("<h1>Hi!</h1>").to_html


    #docx = File.read("#{Rails.root}/public/makro.docx")
    #docx = Stuff.last.file.download.force_encoding('UTF-8')

    #@converted = PandocRuby.new(docx, from: 'docx').to_docx
    #@converted = PandocRuby.new(docx, :standalone, from: 'docx').to_docx
    #@converted = PandocRuby.convert(docx, :s, :t, {f: :docx, to: :docx})
    #pandoc -s -t docx -o {$file}_clean.docx $file
    #send_data @converted, filename: "makro.docx"

  end

  def pandoc_output
    file = params[:file]
    filename = file.original_filename

    stuff = Stuff.create(filename: filename)
    stuff.file.attach(file)
    docx = stuff.file.download.force_encoding('UTF-8')

    from = params[:from]
    to = params[:to]

    @converted = PandocRuby.new(docx, :standalone, from: from, to: to).convert

    #@converted = PandocRuby.new(docx, :standalone, from: 'docx').to_docx

    #send_data @converted, filename: "#{filename.split('.').first}_clean.docx"
    send_data @converted, filename: "#{filename.split('.').first}_clean.#{Stuff.get_extension(to)}"

    stuff.delete
  end
end
