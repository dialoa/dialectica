class RequestedReviewer < ApplicationRecord
  belongs_to :submission
  def self.status_options
    ["open", "accepted", "rejected"]
  end
end
