class ExternalReferee < ApplicationRecord
  has_many :external_referee_submissions
  has_many :submissions, :through => :external_referee_submissions

  def name
    "#{self.firstname} #{self.lastname}"
  end

  def name_and_email
    "#{self.firstname} #{self.lastname} - #{self.email}"
  end

  def self.placeholders(external_referee = nil)
    {
      "external_referee.firstname": external_referee && external_referee.firstname ? external_referee.firstname : "Max",
      "external_referee.lastname": external_referee && external_referee.lastname ? external_referee.lastname : "Mustermann",
    }
  end

end
