class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy, :panel, :show_pool]
  before_action :authenticate_user!, only: [:my_submissions, :pool]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  def show_pool
  end

  def my_submissions
    @submmissions = current_user.submissions
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)
    #@submission.history = @submission.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")}: </strong> #{current_user.firstname} #{current_user.lastname} created Submission</p>"
    #byebug
    respond_to do |format|
      if @submission.save
        format.html {
          @submission.add_to_history(current_user, "Created Submission")
          params[:submission]["blocked_users"].reject!(&:blank?).each do |blocked_user|
            BlockedUser.create(user_id: blocked_user, submission_id: @submission.id)
          end
          redirect_to @submission, notice: 'Submission was successfully created.'
        }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html {
          @submission.add_to_history(current_user, "Updated Submission")
          params[:submission]["blocked_users"].reject!(&:blank?).each do |blocked_user|
            BlockedUser.create(user_id: blocked_user, submission_id: @submission.id)
          end
          redirect_to @submission, notice: 'Submission was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pool
    @selection = params[:selection].present? ? params[:selection] : "without_reviewers"

    #@submissions_without_reviewers = Submission.includes(:users).where( :users => { :id => nil } )
    @submissions_without_reviewers = Submission.alive.not_blacklisted(current_user).left_outer_joins(:users).where( users: { id: nil } )
    @submissions_with_reviewers = Submission.alive.not_blacklisted(current_user).where.not(id: @submissions_without_reviewers.pluck(:id)).order(:created_at)
    @submissions_suggested_to_me = Submission.alive.not_blacklisted(current_user).where(id: SuggestionSubmission.where(user_id: current_user.id).pluck(:submission_id))
    @proposed_submissions = Submission.alive.not_blacklisted(current_user).where(proposed: "true")
    @dead_submissions = Submission.dead.not_blacklisted(current_user)
    @submissions_to_be_reviewed_by_me = current_user.submissions.alive.not_blacklisted(current_user).order(:created_at)
    @all_submissions = Submission.alive.not_blacklisted(current_user).order(:created_at)

    if @selection == "without_reviewers"
      @submissions = @submissions_without_reviewers.order(:created_at)
    elsif @selection == "with_reviewers"
      @submissions = @submissions_with_reviewers
    elsif @selection == "by_me"
      @submissions = @submissions_to_be_reviewed_by_me
    elsif @selection == "all"
      @submissions = @all_submissions
    elsif @selection == "suggested_to_me"
      @submissions = @submissions_suggested_to_me
    elsif @selection == "proposed_submissions"
      @submissions = @proposed_submissions
    elsif @selection == "dead_submissions"
      @submissions = @dead_submissions
    end
    #@submissions = Submission.all.order(:created_at)

    #submissions_with_reviewers = Submission.where.not(id: submissions_without_reviewers.pluck(:id))
  end

  def panel

  end

  def update_status_of_submission
    submission = Submission.find(params[:submission_id])
    submission.update(status: params[:status])
    redirect_to submission_path(submission), notice: 'Suggestion added'
  end

  def upload_file_to_submission
    submission = Submission.find(params[:submission_id])
    submission.attachments.attach(params[:attachments])
    message = "Uploaded a file: "
    attachment = submission.attachments.order(:created_at).last
    link = helpers.link_to("#{attachment.filename}", rails_blob_path(attachment, disposition: "attachment"))
    submission.add_to_history(current_user, message + " " + link)
    #submission.add_attachment_to_history(current_user, submission.attachments.order(:created_at).last)
    redirect_to submission_path(submission), notice: message
  end

  def add_comment_to_submission
    submission = Submission.find(params[:id])
    comment = params[:comment][:comment]
    message = "Added Comment"
    submission.add_to_history(current_user, comment)
    redirect_to submission_path(submission), notice: message
  end



  def create_suggestion_to_user
    submission = Submission.find(params[:submission_id])
    SuggestionSubmission.create(user_id: params[:user_id], submission_id: submission.id)
    #redirect_to submission_pool_path, notice: 'Suggestion added'
    message = "suggested to #{User.find(params[:user_id]).name}"
    submission.add_to_history(current_user, message)
    redirect_to submission_path(params[:submission_id]), notice: 'Suggestion added'
  end

  def send_to_external_referee
    @mail = params[:send_to_external_referee][:mail]
    @subject = params[:send_to_external_referee][:subject]
    @body = params[:send_to_external_referee][:body]

    message = "sent to external referee: " + @mail
    submission = Submission.find(params[:submission_id])
    submission.add_to_history(current_user, message)
    #redirect_to submission_path(params[:submission_id]), notice: message
  end

  def propose_submission
    submission = Submission.find(params[:submission_id])
    submission.update(proposed: "true")
    submission.add_to_history(current_user, "Proposed Submission")
    #redirect_to submission_path(submission), notice: 'Submission has been proposed'
    redirect_to submission_path(params[:submission_id]), notice: 'Proposed Submission'
  end

  def withdraw_proposal_of_submission
    submission = Submission.find(params[:submission_id])
    submission.update(proposed: "false")
    submission.add_to_history(current_user, "Withdrew proposal of Submission")
    redirect_to submission_path(submission), notice: 'Submission proposal has been withdrawn'
  end

  def make_submission_dead
    submission = Submission.find(params[:submission_id])
    submission.update(dead: "true")
    submission.add_to_history(current_user, "Submission is dead")
    redirect_to submission_path(submission), notice: 'Submission is dead'
  end

  def make_submission_alive
    submission = Submission.find(params[:submission_id])
    submission.update(dead: "false")
    submission.add_to_history(current_user, "Submission is alive")
    redirect_to submission_path(submission), notice: 'Submission is alive'
  end

  def add_user_to_submission
    @user = User.find(params[:user_id])
    @submission = Submission.find(params[:submission_id])
    @user.submissions << @submission if @user.submissions.where(id: @submission.id).empty?

    #@submission.update(history: @submission.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")}: </strong> #{current_user.firstname} #{current_user.lastname} signed up as Internal Referee</p>")
    @submission.add_to_history(current_user, "Signed up as Internal Referee")
    #redirect_to submission_pool_path(selection: "by_me"), notice: 'Signed up as Internal Referee'
    redirect_to submission_path(@submission), notice: 'Signed up as Internal Referee'
  end

  def remove_user_from_submission
    @user = User.find(params[:user_id])
    @submission = Submission.find(params[:submission_id])
    @user.submissions.delete(@submission)
    #@user.submissions << @submission if @user.submissions.where(id: @submission.id).empty?

    #@submission.update(history: @submission.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")}: </strong> #{current_user.firstname} #{current_user.lastname} quit as Internal Referee</p>")
    @submission.add_to_history(current_user, "Quit as Internal Referee")

    #redirect_to submission_pool_path, notice: 'Quit as Internal Referee'
    redirect_to submission_path(@submission), notice: 'Quit as Internal Referee'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:title, :area, :firstname, :lastname, :file, :email, :history, :country, :gender, :other_authors, :attachments)
    end
end
