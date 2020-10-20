class Submission < ApplicationRecord
has_many :submission_users
has_many :users, :through => :submission_users
  has_one_attached :file

  def self.areas
    ["metaphysics", "epistemology", "philosophy of science", "ethics"]
  end

  def self.statuses
    ["submitted", "rejected", "published", "review"]
  end

end
