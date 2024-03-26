require 'bibtex'
require 'citeproc'
require 'csl/styles'
require 'serrano'

class StaticPagesController < ApplicationController
  def welcome_user

  end

  def bibtex
    @b = BibTeX.open('./public/bibtex/dialectica-sandro.bib')
  end

  def submission_welcome

  end

  def dashboard

  end

  def dashboard2

  end

  def welcome

  end

end
