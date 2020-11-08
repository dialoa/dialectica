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

  def submission_urgency
    if created_at > Date.today - 2.weeks
      return "table-primary"
    elsif created_at > Date.today - 4.weeks
      return "table-warning"
    else
      return "table-danger"
    end
  end

end
