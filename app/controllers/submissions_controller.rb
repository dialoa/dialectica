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
          @submission.add_to_history(current_user, "Created Submission".downcase)
          params[:submission]["blocked_users"].reject!(&:blank?).each do |blocked_user|
            BlockedUser.create(user_id: blocked_user, submission_id: @submission.id)
          end
          redirect_to @submission, notice: 'submission was successfully created.'
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
          @submission.add_to_history(current_user, "updated submission")
          params[:submission]["blocked_users"].reject!(&:blank?).each do |blocked_user|
            BlockedUser.create(user_id: blocked_user, submission_id: @submission.id)
          end
          redirect_to @submission, notice: 'submission was successfully updated.'
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
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.'.downcase }
      format.json { head :no_content }
    end
  end

  def pool
    @selection = params[:selection].present? ? params[:selection] : "all"

    #@submissions_without_reviewers = Submission.includes(:users).where( :users => { :id => nil } )
    @submissions_without_reviewers = Submission.alive.not_blacklisted(current_user).left_outer_joins(:users).where( users: { id: nil } )
    @submissions_with_reviewers = Submission.alive.not_blacklisted(current_user).where.not(id: @submissions_without_reviewers.pluck(:id)).order(:appearance_date)
    @submissions_suggested_to_me = Submission.alive.not_blacklisted(current_user).where(id: SuggestionSubmission.where(user_id: current_user.id).pluck(:submission_id))
    @proposed_submissions = Submission.alive.not_blacklisted(current_user).where(proposed: "true")
    @dead_submissions = Submission.dead.not_blacklisted(current_user)
    @submissions_to_be_reviewed_by_me = current_user.submissions.alive.not_blacklisted(current_user).order(:appearance_date)
    @all_submissions = Submission.not_blacklisted(current_user).order(:appearance_date)
    @all_open_submissions = Submission.alive.not_blacklisted(current_user).order(:appearance_date)

    if @selection == "without_reviewers"
      @submissions = @submissions_without_reviewers.order(:appearance_date)
    elsif @selection == "with_reviewers"
      @submissions = @submissions_with_reviewers.order(:appearance_date)
    elsif @selection == "by_me"
      @submissions = @submissions_to_be_reviewed_by_me.order(:appearance_date)
    elsif @selection == "all"
      @submissions = @all_submissions.order(:appearance_date)
    elsif @selection == "all_open"
      @submissions = @all_open_submissions.order(:appearance_date)
    elsif @selection == "suggested_to_me"
      @submissions = @submissions_suggested_to_me.order(:appearance_date)
    elsif @selection == "proposed_submissions"
      @submissions = @proposed_submissions.order(:appearance_date)
    elsif @selection == "dead_submissions"
      @submissions = @dead_submissions.order(:appearance_date)
    end
    #@submissions = Submission.all.order(:created_at)

    #submissions_with_reviewers = Submission.where.not(id: submissions_without_reviewers.pluck(:id))
  end

  def panel

  end

  def send_notifications
    User.send_notifications
    #render status: :ok
    redirect_to root_path, notice: "notifications are being sent"
  end

  def update_status_of_submission
    submission = Submission.find(params[:submission_id])
    submission.update(status: params[:status])
    redirect_to submission_path(submission), notice: 'Suggestion added'.downcase
  end

  def upload_file_to_submission
    submission = Submission.find(params[:submission_id])
    submission.attachments.attach(params[:attachments])
    message = "Uploaded a file: ".downcase
    attachment = submission.attachments.order(:created_at).last
    link = helpers.link_to("#{attachment.filename}", rails_blob_path(attachment, disposition: "attachment"))
    submission.add_to_history(current_user, message + " " + link)
    #submission.add_attachment_to_history(current_user, submission.attachments.order(:created_at).last)
    redirect_to submission_path(submission), notice: message
  end

  def add_comment_to_submission
    submission = Submission.find(params[:id])
    comment = params[:comment][:comment]
    message = "Added Comment".downcase
    submission.add_to_history(current_user, comment)
    redirect_to submission_path(submission), notice: message
  end



  def create_suggestion_to_user
    submission = Submission.find(params[:submission_id])
    SuggestionSubmission.create(user_id: params[:user_id], submission_id: submission.id)
    suggested_to_user = User.find(params[:user_id])
    #redirect_to submission_pool_path, notice: 'Suggestion added'
body =
"
Dear #{suggested_to_user.name}

#{helpers.link_to submission.title, submission_url(submission)} has been suggested to you by #{current_user.name}.
"
    SubmissionMailer.send_notification_of_suggestion(suggested_to_user, "dialectica - a submission has been suggested to you", body).deliver_now if suggested_to_user.notify_me_when_i_am_suggested_as_an_internal_referee == "yes"
    message = "suggested to #{User.find(params[:user_id]).name}"
    submission.add_to_history(current_user, message)
    #byebug
    redirect_to submission_path(params[:submission_id]), notice: 'Suggestion added'.downcase
  end

  def send_to_external_referee
    #@mail = params[:send_to_external_referee][:mail]
    @subject = params[:send_to_external_referee][:subject]
    @body = params[:send_to_external_referee][:body]
    #@firstname = params[:send_to_external_referee][:firstname]
    #@lastname = params[:send_to_external_referee][:lastname]
    @external_referee = ExternalReferee.find(params[:send_to_external_referee][:external_referee])

    @mail = @external_referee.email

    @sending_option = params[:send_directly]

    message = "sent to external referee: #{@external_referee.name_and_email}"
    submission = Submission.find(params[:submission_id])
    @submission = submission
    submission.add_to_history(current_user, message)
    #ExternalReferee.create(email: @mail, firstname: @firstname, lastname: @lastname)
    submission.external_referees << @external_referee
    #RequestedReviewer.create(email: @mail, firstname: @firstname, lastname: @lastname, submission_id: submission.id)
    #byebug
    #redirect_to submission_path(params[:submission_id]), notice: message

    if params[:send_directly]
      SubmissionMailer.send_to_external_referee(@mail, @subject, @body, current_user).deliver_now
    else
      #byebug
    end
  end

  def propose_submission
    submission = Submission.find(params[:submission_id])
    submission.update(proposed: "true")
    submission.add_to_history(current_user, "Proposed Submission".downcase)
    #redirect_to submission_path(submission), notice: 'Submission has been proposed'
    redirect_to submission_path(params[:submission_id]), notice: 'Proposed Submission'.downcase
  end

  def withdraw_proposal_of_submission
    submission = Submission.find(params[:submission_id])
    submission.update(proposed: "false")
    submission.add_to_history(current_user, "Withdrew proposal of Submission".downcase)
    redirect_to submission_path(submission), notice: 'Submission proposal has been withdrawn'.downcase
  end

  def make_submission_dead
    submission = Submission.find(params[:submission_id])
    submission.update(dead: "true")
    submission.add_to_history(current_user, "Submission is dead".downcase)
    redirect_to submission_path(submission), notice: 'Submission is dead'.downcase
  end

  def make_submission_alive
    submission = Submission.find(params[:submission_id])
    submission.update(dead: "false")
    submission.add_to_history(current_user, "Submission is alive".downcase)
    redirect_to submission_path(submission), notice: 'Submission is alive'.downcase
  end

  def resurrect_submission
    submission = Submission.find(params[:submission_id])
    submission.update(appearance_date: Date.today)
    message = "Submission resurrected".downcase
    submission.add_to_history(current_user, message)
    redirect_to submission_path(submission), notice: message
  end

  def accept_submission
    submission = Submission.find(params[:submission_id])
    submission.update(dead: "true")
    message = "Submission accepted".downcase
    submission.add_to_history(current_user, message)
    redirect_to submission_path(submission), notice: message
  end

  def reject_submission
    submission = Submission.find(params[:submission_id])
    submission.update(dead: "true")
    message = "Submission rejected".downcase
    submission.add_to_history(current_user, message)
    redirect_to submission_path(submission), notice: message
  end

  def add_user_to_submission
    @user = User.find(params[:user_id])
    @submission = Submission.find(params[:submission_id])
    @user.submissions << @submission if @user.submissions.where(id: @submission.id).empty?

    #@submission.update(history: @submission.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")}: </strong> #{current_user.firstname} #{current_user.lastname} signed up as Internal Referee</p>")
    @submission.add_to_history(current_user, "Signed up as Internal Referee".downcase)
    #redirect_to submission_pool_path(selection: "by_me"), notice: 'Signed up as Internal Referee'
    redirect_to submission_path(@submission), notice: 'Signed up as Internal Referee'.downcase
  end

  def remove_user_from_submission
    @user = User.find(params[:user_id])
    @submission = Submission.find(params[:submission_id])
    @user.submissions.delete(@submission)
    #@user.submissions << @submission if @user.submissions.where(id: @submission.id).empty?

    #@submission.update(history: @submission.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")}: </strong> #{current_user.firstname} #{current_user.lastname} quit as Internal Referee</p>")
    @submission.add_to_history(current_user, "Quit as Internal Referee".downcase)

    #redirect_to submission_pool_path, notice: 'Quit as Internal Referee'
    redirect_to submission_path(@submission), notice: 'Quit as Internal Referee'.downcase
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:title, :area, :firstname, :lastname, :file, :email, :history, :country, :gender, :other_authors, :attachments, :comment, :appearance_date)
    end
end
