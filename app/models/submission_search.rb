class SubmissionSearch
  def initialize(search_string="", selection="all", user_id=nil, rewiever_id=nil)
    @search_string = search_string
    @selection = selection
    @submissions = Submission.all
    @user = User.where(id: user_id).empty? ? nil : User.find(user_id)
    @reviewer = User.where(id: rewiever_id).empty? ? nil : User.find(rewiever_id)
  end

  def search
    select()

    unless @user.nil?
      @submissions.ilike_search_field(@search_string).not_blacklisted(@user).order(created_at: :desc)
    else
      @submissions.ilike_search_field(@search_string).order(created_at: :desc)
    end

  end

  def select

    if @selection == "without internal reviewers"
      #@submissions = @submissions.left_outer_joins(:users).where( users: { id: nil } )
      #@submissions = @submissions.left_joins(:users).where('users.id IS NULL').distinct
      array_of_ids = []
      Submission.all.each do |submission|
        if submission.users.count == 0
          array_of_ids.push(submission.id)
        end
      end

      @submissions = @submissions.where(id: array_of_ids)

    end

    if @selection == "with one reviewer"
      array_of_ids = []
      @submissions.left_joins(:users).where('users.id IS NOT NULL').distinct.each do |submission|
        if submission.users.count == 1
          array_of_ids.push(submission.id)
        end
      end

      @submissions = @submissions.where(id: array_of_ids)
    end

    if @selection == "with internal reviewers"
      @submissions = @submissions.left_joins(:users).where('users.id IS NOT NULL').distinct
    end

    if @selection == "suggested to me"
      @submissions = @submissions.where(id: SuggestionSubmission.where(user_id: @user.id).pluck(:submission_id))
    end

    if @selection == "proposed for acceptance"
      @submissions = @submissions.where(proposed_for_acceptance: "true")
    end

    if @selection == "proposed for rejection"
      @submissions = @submissions.where(proposed_for_rejection: "true")
    end

    if @selection == "proposed for discussion"
      @submissions = @submissions.where(proposed_for_discussion: "true")
    end

    if @selection == "accepted"
      @submissions = @submissions.where(accepted: "true")
    end

    if @selection == "rejected"
      @submissions = @submissions.where(rejected: "true")
    end

    if @selection == "withdrawn"
      @submissions = @submissions.where(withdrawn: "true")
    end

    if @selection == "not withdrawn"
      @submissions = @submissions.where.not(withdrawn: "true")
    end

    if @selection == "dead"
      @submissions = @submissions.dead
    end

    if @selection == "reviewed by me"
      @submissions = @user.submissions
    end

    if @selection == "open"
      @submissions = @submissions.alive
    end

    if @selection == "sent back"
      #array_of_ids = []

      old_submissions = Submission.where("appearance_date < ?", Date.today - 31.days).where.not(accepted: "true").where.not(rejected: "true")

      @submissions = @submissions.where(id: old_submissions.pluck(:id))

    end



    unless @reviewer.blank?
      array_of_ids = @reviewer.submissions.pluck(:id)
      @submissions = @submissions.where(id: array_of_ids)
    end

  end

  def self.options
    [
      "all",
      "without internal reviewers",
      #"with one reviewer",
      "with internal reviewers",
      "suggested to me",
      "proposed for acceptance",
      "proposed for rejection",
      "proposed for discussion",
      "accepted",
      "rejected",
      #"dead",
      "reviewed by me",
      #"open",
      "withdrawn",
      "not withdrawn",
      "sent back"
      ]
  end
end
