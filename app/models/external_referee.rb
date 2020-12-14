class ExternalReferee < ApplicationRecord
  has_many :external_referee_submissions
  has_many :submissions, :through => :external_referee_submissions

  def name
    "#{self.firstname} #{self.lastname}"
  end

  def name_and_email
    "#{self.firstname} #{self.lastname} - #{self.email}"
  end

end
