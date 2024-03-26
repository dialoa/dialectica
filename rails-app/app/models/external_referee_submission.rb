class ExternalRefereeSubmission  < ApplicationRecord
  belongs_to :external_referee
  belongs_to :submission

  def self.status_options
    ["no answer", "request accepted", "request denied", "positive", "negative"]
  end

end
