class Submission < ApplicationRecord
  has_many :submission_users
  has_many :users, :through => :submission_users
  has_one_attached :file
  has_many_attached :attachments
  has_many :histories
  #has_many :suggestion_submissions

  has_many :reports

  #after_create :add_create_to_history

  scope :dead, -> { where(dead: "true") }
  scope :alive, -> { where(dead: "false") }

  def self.areas
    ["metaphysics", "epistemology", "philosophy of science", "ethics"]
  end

  def self.gender_options
    ["male", "female", "transgender"]
  end

  def self.statuses
    ["submitted", "rejected", "accepted", "proposed", "published", "review"]
  end

  def self.frame_statuses
    ["non-active", "half-active", "active", "proposed"]
  end

  def self.proposed_statuses
    ["false", "true"]
  end

  def self.dead_statuses
    ["false", "true"]
  end

  def get_frame_status_color(user)
    submissions_suggested_to_me = Submission.where(id: SuggestionSubmission.where(user_id: user.id).pluck(:submission_id)).pluck(:id)
    #byebug
    case
    when submissions_suggested_to_me.include?(self.id) then "border-info thick-borders-3"
    #when SuggestionSubmission.where(user_id: user.id).where(submission_id: self.id).empty? then "border-info thick-borders-3"
    when self.users.count == 2 then "border-warning thick-borders-3"
    when self.users.count == 1 then "border-primary thick-borders-3"
    else ""
    end
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
    when self.frame_status == "suggested_to_me" then "border-info thick-borders-3"
    when self.frame_status == "active" then "border-warning thick-borders-3"
    when self.frame_status == "half-active" then "border-primary thick-borders-3"
    when self.frame_status == "non-active" then ""
    else ""
    end
  end

  def suggested_to_me?(user)
    submissions_suggested_to_me = Submission.where(id: SuggestionSubmission.where(user_id: user.id).pluck(:submission_id)).pluck(:id)
    submissions_suggested_to_me.include?(self.id)
  end

  def submission_urgency
    if created_at > Date.today - 2.weeks
      return "bg-color-light-green"
    elsif created_at > Date.today - 4.weeks
      return "bg-color-dark-green"
    elsif created_at > Date.today - 6.weeks
      return "bg-color-light-red"
    elsif created_at > Date.today - 8.weeks
      return "bg-color-dark-red text-white"
    elsif created_at > Date.today - 10.weeks
      return "bg-color-violet"
    elsif created_at > Date.today - 12.weeks
      return "bg-color-dark-grey"
    else
      return "bg-color-black text-white"
    end
  end

  def add_create_to_history
    history = self.history + "<p><strong>#{self.created_at.strftime("%d.%m.%Y")} - #{current_user.firstname} #{current_user.lastname}</strong> Submission created </p>"
    self.update(history: history)
  end

  def add_to_history(user, message)
    #history = self.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")} - #{user.name}</strong>: <br>" + message + "</p>"
    #self.update(history: history)
    history = History.create(content: message, user_id: user.id, submission_id: self.id)
  end

  def add_attachment_to_history(user, attachment)
    history = self.history + "<p><strong>#{self.created_at.strftime("%d.%m.%Y")} - #{user.name}</strong>: <br>" + "#{link_to "Download File", rails_blob_path(attachment, disposition: "attachment")}" + "</p>"
    self.update(history: history)
  end

  def self.make_old_submissions_dead
    old_submissions = Submission.where("created_at < ?", Date.today - 13.weeks)
    old_submissions.update_all(dead: "true")
  end

end
