class Submission < ApplicationRecord

  has_many :question_answers

  has_many :external_referee_submissions
  has_many :external_referees, :through => :external_referee_submissions

  has_many :submission_users
  has_many :users, :through => :submission_users
  has_one_attached :file
  has_many_attached :attachments
  has_many :histories, dependent: :destroy
  has_many :requested_reviewers
  has_many :media, as: :mediumable

  #has_many :suggestion_submissions

  has_many :reports
  has_many :blocked_users

  #after_create :add_create_to_history
  after_create :add_appearance_date
  #after_create :set_dialectica_id # let's not to this, might mess up upload csv

  before_save :update_search_field

  def update_search_field

    self.search_field =
    [
      id,
      dialectica_id,
      title,
      firstname,
      lastname,
      email,
      comment
    ].compact.join(' ')

  end

  scope :ilike_search_field, ->(search_term) { where("search_field ILIKE ?", "%#{search_term}%") }

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  #validates :dialectica_id, uniqueness: true # the problem is in upload csv: save fails if there is already dialectica id
  validates :title, presence: true#, uniqueness: true
  validates :file, attached: true, content_type: { in: 'application/pdf', message: 'is not a PDF' }, size: { less_than: 1.megabytes , message: 'is too large' }
  #validates :attachments, attached: true, size: { less_than: 5.megabytes , message: 'is too large' }


  scope :dead, -> { where(dead: "true") }
  scope :alive, -> { where(dead: "false") }
  #scope :visible_to_user, -> { where(dead: "false") }
  scope :not_blacklisted, ->(user) { where.not(id: BlockedUser.where(user_id: user.id).pluck(:submission_id)) }

  def name
    "#{self.firstname} #{self.lastname}"
  end

  def status_for_author
    return "rejected" if self.rejected == "true"
    return "accepted" if self.accepted == "true"
    return "withdrawn" if self.withdrawn == "true"
    return "dead" if self.dead == "true"
    return "open"
  end

  def dialectica_id_public
    if self.dialectica_id.nil?
      self.id
    else
      self.dialectica_id
    end
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

  def self.proposed_for_discussion_statuses
    ["false", "true"]
  end


  def self.withdrawn_options
    ["false", "true"]
  end

  def self.dead_statuses
    ["false", "true"]
  end

  def self.dead_options
    ["false", "true"]
  end

  def self.accepted_options
    ["false", "true"]
  end

  def self.rejected_options
    ["false", "true"]
  end

  def self.extended_appearance_date_for_send_to_external_referee
    ["false", "true"]
  end

  def open?

  end

  def self.placeholders(submission = nil)
    {
      "submission.title": submission && submission.title ? submission.title : "Ship of Theseus",
      "submission.dialectica_id": submission && submission.dialectica_id ? submission.dialectica_id.to_s : "1234",
      "submission.download_url": submission && submission.file.attached? ? Rails.application.routes.url_helpers.rails_blob_url(submission.file) : "https://website.com/download_url",
      "submission.a_href": submission && submission.file.attached? ? "<a href=\"#{Rails.application.routes.url_helpers.rails_blob_url(submission.file)}\">download</a>" : '<a href="url">download</a>'
    }
  end


  def self.send_to_external_referee_text(submission, submission_blob_url, user, external_referee = nil)

    if user.blank?
      user = User.find_by_email("anonymous_user@mail.com")
    end

    email_template = EmailTemplate.find_by_name("send to external referee")

    if email_template.nil?
      email_template = EmailTemplate.create(name: "send to external referee", content: "please edit this template.")
    end

   ScanAndSubstitute.new(content: email_template.content, submission: submission, user: user, external_referee: external_referee).scan_and_substitute


  end

  def self.send_to_external_referee_text(submission, submission_blob_url, user, external_referee = nil)

    if user.blank?
      user = User.find_by_email("anonymous_user@mail.com")
    end

    email_template = EmailTemplate.find_by_name("send to external referee")

    if email_template.nil?
      email_template = EmailTemplate.create(name: "send to external referee", content: "please edit this template.")
    end

   ScanAndSubstitute.new(content: email_template.content, submission: submission, user: user, external_referee: external_referee).scan_and_substitute


  end

  def self.notify_user_that_submission_expires_soon_text(submission: submission, user: user)
    email_template = EmailTemplate.find_by_name("notify user that submission expires soon")

    if email_template.nil?
      email_template = EmailTemplate.create(name: "notify user that submission expires soon", content: "please edit this template")
    end

    ScanAndSubstitute.new(content: email_template.content, submission: submission, user: user).scan_and_substitute
  end

  def self.new_submission_text(submission: submission, user: user)

    email_template = EmailTemplate.find_by_name("new submission")

    if email_template.nil?
      email_template = EmailTemplate.create(name: "new submission", content: "please edit this template")
    end

    ScanAndSubstitute.new(content: email_template.content, submission: submission, user: user).scan_and_substitute

  end

  def self.ask_author_a_question_text(user: user, submission: submission, question_answer: question_answer)

    email_template = EmailTemplate.find_by_name("ask author a question")

    if email_template.nil?
      email_template = EmailTemplate.create(name: "ask author a question", content: "please edit this template")
    end

    ScanAndSubstitute.new(content: email_template.content, user: user, submission: submission, question_answer: question_answer).scan_and_substitute

  end


  def self.one_month_passed_without_case_text(submission: submission, user: user)

    email_template = EmailTemplate.find_by_name("one month passed without case")

    if email_template.nil?
      email_template = EmailTemplate.create(name: "one month passed without case", content: "please edit this template")
    end

    ScanAndSubstitute.new(content: email_template.content, submission: submission, user: user).scan_and_substitute

  end

  def self.withdraw_submission_email_text(submission: submission, user: user)

    template_name = "withdraw submission"

    email_template = EmailTemplate.find_by_name(template_name)

    if email_template.nil?
      email_template = EmailTemplate.create(name: template_name, content: "please edit this template")
    end

    ScanAndSubstitute.new(content: email_template.content, submission: submission, user: user).scan_and_substitute

  end

  def self.send_rejection_to_author_text(submission: submission, user: user)

    template_name = "reject submission"

    email_template = EmailTemplate.find_by_name(template_name)

    if email_template.nil?
      email_template = EmailTemplate.create(name: template_name, content: "please edit this template")
    end

    ScanAndSubstitute.new(content: email_template.content, submission: submission, user: user).scan_and_substitute

  end

  def self.new_submission_with_login_text(submission: submission, user: user, password: password)

    email_template = EmailTemplate.find_by_name("new submission with login")

    if email_template.nil?
      email_template = EmailTemplate.create(name: "new submission with login", content: "please edit this template")
    end

    ScanAndSubstitute.new(content: email_template.content, submission: submission, user: user, password: password).scan_and_substitute


  end

  def get_frame_status_color(user)
    #submissions_suggested_to_me = Submission.where(id: SuggestionSubmission.where(user_id: user.id).pluck(:submission_id)).pluck(:id)
    #byebug
    case
    #when submissions_suggested_to_me.include?(self.id) then "border-info thick-borders-6"
    #when SuggestionSubmission.where(user_id: user.id).where(submission_id: self.id).empty? then "border-info thick-borders-3"
    when self.users.count >= 2 then "border-light-yellow thick-borders-6"
    when self.users.count == 1 then "border-dark-yellow thick-borders-6"
    else ""
    end
  end

  def frame_status
    case
    when self.users.count >= 2 then "active"
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
    if accepted == "true"
      return "bg-color-dialectica-blue"
    elsif appearance_date > Date.today - 6.days
      #hellgrün
      return "bg-color-light-green"
    elsif appearance_date > Date.today - 13.days
      #dunkelgrün
      return "bg-color-dark-green"
    elsif appearance_date > Date.today - 19.days
      #dunkelrot
      return "bg-color-dark-red"
    elsif appearance_date > Date.today - 31.days
      #hellrot
      return "bg-color-light-red text-white"
    else
      #danach schwarz
      return "bg-color-black text-white"
    end
  end

  def add_create_to_history
    history = self.history + "<p><strong>#{self.created_at.strftime("%d.%m.%Y")} - #{current_user.firstname} #{current_user.lastname}</strong> Submission created </p>"
    self.update(history: history)
  end

  def set_dialectica_id
    maximum = Submission.maximum(:dialectica_id)
    if maximum.nil?
      maximum = 4396
    else
      maximum = maximum + 1
    end

    self.update(dialectica_id: maximum)
  end

  def add_appearance_date
    #byebug
    self.update(appearance_date: self.created_at.to_date)
    puts self.appearance_date
  end

  def add_to_history(user, message, alternative_name = "", category: "")
    #history = self.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")} - #{user.name}</strong>: <br>" + message + "</p>"
    #self.update(history: history)
    #byebug
    history = History.create(content: message, user_id: user.id, submission_id: self.id, alternative_name: alternative_name, category: category)
  end

  def add_attachment_to_history(user, attachment)
    history = self.history + "<p><strong>#{self.created_at.strftime("%d.%m.%Y")} - #{user.name}</strong>: <br>" + "#{link_to "Download File", rails_blob_path(attachment, disposition: "attachment")}" + "</p>"
    self.update(history: history)
  end

  def self.make_old_submissions_dead
    old_submissions = Submission.where("created_at < ?", Date.today - 13.weeks)
    old_submissions.update_all(dead: "true")
  end

  def flow_chart
    dataset =  {
      "nodes": [
        {
          "phase_id": 1,
          "x": 1,
          "y": 0,
        },
        {
          "phase_id": 2,
          "x": 1,
          "y": 1,
        },
        {
          "phase_id": 3,
          "x": 1,
          "y": 2,
        },
        {
          "phase_id": 4,
          "x": 2,
          "y": 1,
        },
        #{
        #  "phase_id": 5,
        #  "x": 3,
        #  "y": 2,
        #},
        {
          "phase_id": 6,
          "x": 1,
          "y": 3,
        },
        {
          "phase_id": 7,
          "x": 1,
          "y": 4,
        },
        {
          "phase_id": 8,
          "x": 0,
          "y": 4,
        },
        {
          "phase_id": 9,
          "x": 0,
          "y": 3,
        },
        #{
        #  "phase_id": 10,
        #  "x": 2,
        #  "y": 5,
        #},
        {
          "phase_id": 11,
          "x": 2,
          "y": 5,
        },
        {
          "phase_id": 12,
          "x": 1,
          "y": 5,
        },
        {
          "phase_id": 13,
          "x": 1,
          "y": 6,
        },
        {
          "phase_id": 14,
          "x": 2,
          "y": 6,
        },
        {
          "phase_id": 15,
          "x": 1,
          "y": 7,
        },
        {
          "phase_id": 16,
          "x": 2,
          "y": 7,
        },
        {
          "phase_id": 17,
          "x": 1,
          "y": 8,
        },
        {
          "phase_id": 18,
          "x": 1,
          "y": 9,
        },
      ],
      "links": [
        {"source": 1, "target": 2},
        {"source": 2, "target": 3},
        {"source": 2, "target": 4},
        #{"source": 4, "target": 5},
        {"source": 3, "target": 6},
        {"source": 6, "target": 7},
        {"source": 7, "target": 8},
        {"source": 8, "target": 9},
        {"source": 9, "target": 6},
        #{"source": 7, "target": 10},
        #{"source": 10, "target": 11},
        {"source": 12, "target": 11},
        {"source": 7, "target": 12},
        {"source": 12, "target": 13},
        {"source": 13, "target": 14},
        {"source": 13, "target": 15},
        {"source": 15, "target": 16},
        {"source": 15, "target": 17},
        {"source": 17, "target": 18}
      ],
      "text_above_links": [
        {
          "x": 1.5,
          "y": 1,
          "text1": "after",
          "text2": "one month"
        },
        {
          "x": 1.5,
          "y": 5.0,
          "text1": "if more than",
          "text2": "3 months pass"
        }
      ]
    }

    dataset[:nodes].each do |node|
      phase_id = node[:phase_id].to_i
      text = Submission.phases[phase_id-1]
      node[:id] = text.parameterize
      node[:text] = text

      current_phase = Submission.phases[2]
      current_phase_index = Submission.phases.index(current_phase)
      if phase_id == current_phase_index
        node[:your_article_is_here_sign] = "yes"
        css_class = "h-100 bg-info rounded p-1 text-white text-center d-flex justify-content-center align-items-center"
      elsif phase_id > current_phase_index
        css_class = "h-100 bg-secondary rounded p-1 text-white text-center d-flex justify-content-center align-items-center"
       elsif phase_id < current_phase_index
        css_class = "h-100 bg-success rounded p-1 text-white text-center d-flex justify-content-center align-items-center"
      end

      node[:class] = css_class
    end



    dataset[:links].push(
      #{"source": 2, "target": 10},
      #{"source": 4, "target": 11},
    )



    return dataset
  end

  def self.phases2
    #["submitted", "published"]
    [
      {
        "name": "author submits article",
        "position": "1",
        "direction": "down",
      },
      {
        "name": "editor assesses article",
        "position": "2",
        "direction": "down"
      },
      {
        "name": "article sent to reviewers",
        "position": "3",
        "direction": "down"
      },
      {
        "name": "editor assesses reviews",
        "position": "4",
        "direction": "left"
      },
      {
        "name": "revisons required",
        "position": "5",
        "direction": "up"
      }
    ]
  end

  def self.phases
    #["submitted", "published"]
    [
      "author submits article",
      "article goes into the pool",
      "an EC member fishes* the article",
      "author is notified", #"after one month",
      "author is notified",
      "article sent to reviewers",
      "EC member assesses reviews (and revisions)",
      "revisions required",
      "author submits revised article",
      "if more than 3 months pass",
      "author is notified",
      "EC member makes a case to the EC",
      "EC agrees with publication (possibly conditional)",
      "author is notified",
      "article is accepted",
      "author is notified",
      "article is in production",
      "article is published"
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

     phases = Submission.phases

     current_phase = Submission.phases[2]

     tree = create_tree_from_phases(phases, 0, current_phase)

     tree = tree[0]

   end

   def create_tree_from_phases(phases, step, current_phase)

     css_class = ""
     your_article_is_here_sign = ""
     reject_is_possible = ""
     #phase = phases[step][:name].parameterize
     id = phase

     if phases[step] == current_phase
       css_class = "bg-info rounded p-1 text-white text-center your_article_is_here_sign"
     elsif step > phases.index(current_phase)
        css_class = "bg-secondary rounded p-1 text-white text-center"
      elsif step < phases.index(current_phase)
        css_class = "bg-success rounded p-1 text-white text-center"
     end

     if step == phases.length - 1
       [
         {
           "content" => phases[step][:name],
           "phase" => phase,
           "class" => css_class,
           "id" => id, #your_article_is_here_sign,
           "reject_is_possible" => reject_is_possible,
           "direction" => phases[step][:direction],
           "children" => []
         }
       ]
     else
       [
         {
           "content" => phases[step][:name],
           "phase" => phase,
           "class" => css_class,
           "id" => id, #your_article_is_here_sign,
           "reject_is_possible" => reject_is_possible,
           "direction" => phases[step][:direction],
           "children" => create_tree_from_phases(phases, step + 1, current_phase)
         }
       ]
     end
   end

   def self.faker_submissions
     array_of_fake_submissions = []

     30.times do
       fake_submission = {
         "title" => Faker::Lorem.uniqe.sentence(word_count: 8),
         "firstname" => Faker::Name.first_name,
         "lastname" => Faker::Name.last_name,
         "email" => Faker::Internet.email,
         "country" => ["CH", "DE", "AT"].sample,
         "comment" => Faker::Lorem.paragraph,
         "other_authors" => Faker::Name.name

       }

       array_of_fake_submissions << fake_submission

     end

     File.open("cypress/fixtures/submissions.json", 'w') { |f| f.write(array_of_fake_submissions.to_json)}

   end

 CSV_ATTRIBUTES = %w{id dialectica_id title firstname lastname email country other_authors comment appearance_date created_at}


  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << CSV_ATTRIBUTES

      Submission.all.each do |submission|
        csv << CSV_ATTRIBUTES.map{ |attr| submission.send(attr) }
      end
    end
  end

  def self.create_or_update_submission(submission)

      submission = submission.select!{|attribute| Submission.attribute_names.index(attribute)}
      submission.delete_if {|key, value| value.blank?}

      if Submission.where(id: submission["id"]).empty?
        new_submission = Submission.new(submission)

        new_submission.file.attach(io: File.open('cypress/fixtures/sample.pdf'), filename: 'file.pdf')

        new_submission.save
        puts new_submission.save!
      else
        update_submission = Submission.find(submission["id"]).update(submission)
      end

  end

  def self.xcreate_or_update_submission_from_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      submission = row.to_hash
      submission = submission.select!{|attribute| Submission.attribute_names.index(attribute)}
      submission.delete_if {|key, value| value.blank?}
      if Submission.where(id: submission["id"]).empty?
        submission = Submission.new(submission)

        submission.file.attach(io: File.open('cypress/fixtures/sample.pdf'), filename: 'file.pdf')

        submission.save
      else
        submission = Submission.find(submission["id"]).update(submission)
      end
    end
  end

end

def archive_send_to_external_referee
  "Dear

  May I ask you whether you would be willing to referee the appended paper
  \"#{submission.title}\", recently submitted to dialectica.
  You may comment freely and/or use the form below. If you do not have
  time to do us this favour (it would be best if you could do it in about
  a month) and/or want to suggest another referee, please feel free to
  tell me so. Many thanks in advance and all the best

  <a href='#{submission_blob_url unless submission_blob_url.blank?}'>#{"Download the paper here" unless submission_blob_url.blank?}</a>


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
