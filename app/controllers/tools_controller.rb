require 'csv'

class ToolsController < ApplicationController
  def csv
    csv_file = params[:csv][:csv_file] if params[:csv].present?
    @array_of_hash = []
    #byebug
    #byebug
    unless csv_file.blank?
      csv = CSV.read(csv_file, :headers => true)
      csv.each do |row|
        user = row.to_hash
        #user = Hash.new
        user["mail"] = Mail::Address.new(row["mail"]).address
        #row["mail"].scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i) { |x| puts x }
        user["firstname"] = row["name"].split.first
        user["lastname"] = row["name"].split.last
        #byebug
        @array_of_hash.push(user)
      end
    end

  end

  def enter_doi_page

  end

  def get_data_from_crossref_with_doi
    @doi = Serrano.works(ids: params[:doi][:doi])
  end

  def get_multiple_data_from_crossref_with_dois
    csv_file = params[:dois][:csv_file] if params[:dois].present?
    @array_of_dois = []
    @dois = []
    unless csv_file.blank?
      csv = CSV.read(csv_file, :headers => true)
      csv.each do |row|
        doi = row["dois"]
        puts doi
        @dois.push(Serrano.works(ids: doi))
      end
    end
    #byebug
  end

end
