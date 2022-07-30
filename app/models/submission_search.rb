class SubmissionSearch
  def initialize(search_string="", selection="all", user_id=nil)
    @search_string = search_string
    @selection = selection
    @submissions = Submission.all
    @user = User.find(user_id).nil? ? nil : User.find(user_id)
  end

  def search
    select()

    @submissions.ilike_search_field(@search_string)
  end

  def select

    if @selection == "without reviewers"
      @submissions = @submissions.left_outer_joins(:users).where( users: { id: nil } )
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

    if @selection == "with reviewers"
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

    if @selection == "accepted"
      @submissions = @submissions.where(accepted: "true")
    end

    if @selection == "rejected"
      @submissions = @submissions.where(rejected: "true")
    end

    if @selection == "dead"
      @submissions = @submissions.dead
    end

    if @selection == "to be reviewed by me"
      @submissions = @user.submissions
    end

    if @selection == "open"
      @submissions = @submissions.alive
    end

  end

  def self.options
    [
      "all",
      "without reviewers",
      "with one reviewer",
      "with reviewers",
      "suggested to me",
      "proposed for acceptance",
      "proposed for rejection",
      "accepted",
      "rejected",
      "dead",
      "to be reviewed by me",
      "open"
      ]
  end
end
