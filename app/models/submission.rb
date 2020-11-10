class Submission < ApplicationRecord
  has_many :submission_users
  has_many :users, :through => :submission_users
  has_one_attached :file

  after_create :add_create_to_history

  def self.areas
    ["metaphysics", "epistemology", "philosophy of science", "ethics"]
  end

  def self.statuses
    ["submitted", "rejected", "published", "review"]
  end

  def submission_urgency
    if created_at > Date.today - 2.weeks
      return "primary text-white"
    elsif created_at > Date.today - 4.weeks
      return "warning text-white"
    else
      return "danger text-white"
    end
  end

  def add_create_to_history
    history = self.history + "<p><strong>#{self.created_at.strftime("%d.%m.%Y")}</strong> Submission created </p>"
    self.update(history: history)
  end

end
