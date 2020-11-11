class Submission < ApplicationRecord
  has_many :submission_users
  has_many :users, :through => :submission_users
  has_one_attached :file
  #has_many :suggestion_submissions

  has_many :reports

  #after_create :add_create_to_history

  def self.areas
    ["metaphysics", "epistemology", "philosophy of science", "ethics"]
  end

  def self.statuses
    ["submitted", "rejected", "published", "review"]
  end

  def self.frame_statuses
    ["non-active", "half-active", "active", "proposed"]
  end

  def frame_status
    case
    when self.users.count == 2 then "active"
    when self.users.count == 1 then "half-active"
    else "non-active"
    end
  end

  def frame_status_color
    case
    when self.frame_status == "active" then "border-warning thick-borders-3"
    when self.frame_status == "half-active" then "border-primary thick-borders-3"
      when self.frame_status == "non-active" then ""
      else ""
    end
  end

  def submission_urgency
    if created_at > Date.today - 2.weeks
      return "success text-white"
    elsif created_at > Date.today - 4.weeks
      return "success text-white"
    elsif created_at > Date.today - 6.weeks
      return "danger text-white"
    elsif created_at > Date.today - 8.weeks
      return "danger text-white"
    elsif created_at > Date.today - 10.weeks
      return "dark text-white"
    else
      return "dark text-white"
    end
  end

  def add_create_to_history
    history = self.history + "<p><strong>#{self.created_at.strftime("%d.%m.%Y")} - #{current_user.firstname} #{current_user.lastname}</strong> Submission created </p>"
    self.update(history: history)
  end

  def add_to_history(user, message)
    history = self.history + "<p><strong>#{self.created_at.strftime("%d.%m.%Y")} - #{user.name}</strong>: " + message + "</p>"
    self.update(history: history)
  end

end
