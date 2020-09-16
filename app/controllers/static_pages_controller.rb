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
    @file_content = file.read.encode('UTF-8').force_encoding('UTF-8') unless file.nil?

    #@converter = PandocRuby.new(@file_content, from: :docx, to: :html).convert unless @file_content.nil?
    @converter = PandocRuby.new(@file_content, :standalone).to_html unless @file_content.nil?
    #send_data @converter.convert

  end
end
