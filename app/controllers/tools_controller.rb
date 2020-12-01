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
        user = Hash.new
        user["mail"] = Mail::Address.new(row["mail"]).address
        #row["mail"].scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i) { |x| puts x }
        user["first_name"] = row["name"].split.first
        user["last_name"] = row["name"].split.last
        #user = row.to_hash
        @array_of_hash.push(user)
      end
    end

  end
end
