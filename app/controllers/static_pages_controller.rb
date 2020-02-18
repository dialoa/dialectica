require 'bibtex'
require 'citeproc'
require 'csl/styles'

class StaticPagesController < ApplicationController
  def welcome
  end

  def bibtex
    #Rails.public_path.join('filename.csv')
    @b = BibTeX.open('./public/bibtex/dialectica-sandro.bib')

  end
end
