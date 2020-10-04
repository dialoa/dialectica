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

end
