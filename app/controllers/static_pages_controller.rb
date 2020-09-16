require 'bibtex'
require 'citeproc'
require 'csl/styles'
require 'serrano'

class StaticPagesController < ApplicationController
  def welcome
  end

  def bibtex
    @b = BibTeX.open('./public/bibtex/dialectica-sandro.bib')

  end

  def pandoc
    file = params[:file]
    @file_content = file.read unless file.nil?
    #utf8_string = @file_content.encode('utf-8')
    #@converted_text = Iconv.conv('utf-8', "ascii", @file_content)

    #@converter = PandocRuby.new(@file_content, from: :docx, to: :html).convert unless @file_content.nil?
    #@converted = PandocRuby.new(file.read, from: 'docx').to_html.convert unless file.nil?
    #@converted = PandocRuby.new("<h1>Hi!</h1>").to_html


    docx = File.read("#{Rails.root}/public/makro.docx")


    @converted = PandocRuby.new(file, from: 'docx').to_docx
    #send_data @converter.convert

  end
end
