class Submission < ApplicationRecord
has_many :external_referee_submissions
has_many :external_referees, :through => :external_referee_submissions

  include Rails.application.routes.url_helpers

  has_many :submission_users
  has_many :users, :through => :submission_users
  has_one_attached :file
  has_many_attached :attachments
  has_many :histories, dependent: :destroy
  has_many :requested_reviewers
  #has_many :suggestion_submissions

  has_many :reports
  has_many :blocked_users

  #after_create :add_create_to_history
  after_create :add_appearance_date



  scope :dead, -> { where(dead: "true") }
  scope :alive, -> { where(dead: "false") }
  #scope :visible_to_user, -> { where(dead: "false") }
  scope :not_blacklisted, ->(user) { where.not(id: BlockedUser.where(user_id: user.id).pluck(:submission_id)) }

  def name
    "#{self.firstname} #{self.lastname}"
  end

  def self.areas
    ["metaphysics", "epistemology", "philosophy of science", "ethics"]
  end

  def self.gender_options
    ["male", "female", "non-binary", "none of the above"]
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

  def self.send_to_external_referee_text(submission, submission_blob_url, user)
    if user.blank?
      user = User.find_by_email("anonymous_user@mail.com")
    end
    #byebug
"Dear

May I ask you whether you would be willing to referee the appended paper
\"#{submission.title}\", recently submitted to dialectica.
You may comment freely and/or use the form below. If you do not have
time to do us this favour (it would be best if you could do it in about
a month) and/or want to suggest another referee, please feel free to
tell me so. Many thanks in advance and all the best

#{"Download the paper here:" unless submission_blob_url.blank?}
#{submission_blob_url unless submission_blob_url.blank?}

#{user.firstname}
member of the Editorial Committee of dialectica

Dialectica
Referee Form

Please assess the paper's originality and the quality of its
argumentation in relation to its length. If you think the paper should
be shortened or expanded, please indicate where.
As many authors of dialectica are not native speakers of English, minor
mistakes should not be held too much against the authors (even if, of
course, they would have to be corrected for publication).
Please bear in mind that Journal policy is to make available as much of
their reports as possible to the authors and adopt a judicious tone in
their assessment, while not forgetting that, if a paper is of very poor
quality the report must indicate this.

1. Please characterise the submitted paper by checking the
relevant box:
[ ] Accepted with no or minor revisions
[ ] Accepted with major revisions
[ ] Rejected with possible resubmission
[ ] rejected

[ ] The paper should not have been sent to referees, but rejected outright.


2. Comments"
  end

  def get_frame_status_color(user)
    #submissions_suggested_to_me = Submission.where(id: SuggestionSubmission.where(user_id: user.id).pluck(:submission_id)).pluck(:id)
    #byebug
    case
    #when submissions_suggested_to_me.include?(self.id) then "border-info thick-borders-6"
    #when SuggestionSubmission.where(user_id: user.id).where(submission_id: self.id).empty? then "border-info thick-borders-3"
    when self.users.count == 2 then "border-light-yellow thick-borders-6"
    when self.users.count == 1 then "border-dark-yellow thick-borders-6"
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
    if appearance_date > Date.today - 2.weeks
      return "bg-color-light-green"
    elsif appearance_date > Date.today - 4.weeks
      return "bg-color-dark-green"
    elsif appearance_date > Date.today - 6.weeks
      return "bg-color-light-red"
    elsif appearance_date > Date.today - 8.weeks
      return "bg-color-dark-red text-white"
    elsif appearance_date > Date.today - 10.weeks
      return "bg-color-violet"
    elsif appearance_date > Date.today - 12.weeks
      return "bg-color-dark-grey"
    else
      return "bg-color-black text-white"
    end
  end

  def add_create_to_history
    history = self.history + "<p><strong>#{self.created_at.strftime("%d.%m.%Y")} - #{current_user.firstname} #{current_user.lastname}</strong> Submission created </p>"
    self.update(history: history)
  end

  def add_appearance_date
    #byebug
    self.update(appearance_date: self.created_at.to_date)
    puts self.appearance_date
  end

  def add_to_history(user, message)
    #history = self.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")} - #{user.name}</strong>: <br>" + message + "</p>"
    #self.update(history: history)
    #byebug
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

  def self.phases
    #["submitted", "published"]
    [
      "author submits article",
      "editor assesses article",
      "article sent to reviewers",
      "editor assesses reviews",
      "article is accepted",
      "article is in production",
      "article is published",
      "revisons required",
      "author submits revised article",
      "rejected"
    ]
  end

  def self.phases_where_reject_is_possible
    ["editor assesses article", "editor assesses reviews"]
  end

  def self.stem_phases
    #["submitted", "published"]
    [
      "author submits article",
      "editor assesses article",
      "article sent to reviewers",
      "editor assesses reviews",
      "article is accepted",
      "article is in production",
      "article is published",
    ]
  end


   def peer_review_process

     phases = Submission.stem_phases

     current_phase = "article sent to reviewers"

     tree = create_tree_from_phases(phases, 0, current_phase)

     tree = tree[0]

   end

   def create_tree_from_phases(phases, step, current_phase)

     css_class = "bg-success rounded p-1 text-white text-center"
     your_article_is_here_sign = ""
     reject_is_possible = ""

     if phases[step] == current_phase
       css_class = "bg-info rounded p-1 text-white text-center"
       your_article_is_here_sign = "your_article_is_here_sign"
     elsif step > phases.index(current_phase)
        css_class = "bg-secondary rounded p-1 text-white text-center"
     end

     if Submission.phases_where_reject_is_possible.include?(phases[step])
       reject_is_possible = "reject_is_possible"
     end

     if step == phases.length - 1
       [
         {
           "content" => phases[step],
           "class" => css_class,
           "id" => your_article_is_here_sign,
           "reject_is_possible" => reject_is_possible,
           "children" => []
         }
       ]
     else
       [
         {
           "content" => phases[step],
           "class" => css_class,
           "id" => your_article_is_here_sign,
           "reject_is_possible" => reject_is_possible,
           "children" => create_tree_from_phases(phases, step + 1, current_phase)
         }
       ]
     end
   end


end
