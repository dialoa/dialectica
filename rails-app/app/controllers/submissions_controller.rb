require 'csv'
require 'json'

class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy, :panel, :show_pool, :show_for_user, :withdraw_submission, :undo_withdraw_submission, :send_rejection_to_author_form, :send_rejection_to_author]
  before_action :authenticate_user!, except: [:show, :new, :create, :iframe_new, :submission_was_successful, :my_submissions]
  skip_before_action :verify_authenticity_token, only: [:create]

  #after_action :verify_authorized, except: [:show, :new, :create]

  # GET /submissions
  # GET /submissions.json
  def index
    authorize Submission
    @submissions = Submission.all.order(created_at: :desc)
  end

  def submission_list
    authorize Submission
    #@submissions = Submission.all.order(created_at: :desc)
    @submissions = SubmissionSearch.new("", "all", current_user.id, current_user.id).search
  end

  def download_csv
    authorize Submission
    send_data Submission.to_csv, filename: "submissions-#{Date.today}.csv"
  end

  def upload_csv
    authorize Submission
    file = params[:file]

    csv = CSV.new(File.read(file), :headers => true, :header_converters => :symbol, :converters => :all)
    #csv = csv.encode("UTF-8")
    csv = csv.to_a.map {|row| row.to_hash }

    @json_of_submissions = csv.to_json

    render "upload_csv_loading_screen"
    #byebug
  end

  def create_or_update_submission
    authorize Submission
    #puts params[:submission]
    submission = params[:submission]
    #byebug
    #byebug
    finished_submission = Submission.create_or_update_submission(submission_params)

    render json: finished_submission
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    #authorize @submission
  end

  def submission
    @submission = Submission.where(dialectica_id: params[:dialectica_id]).first
  end

  def show_pool
    authorize Submission
  end

  def show_for_user
    #authorize @submission
  end

  def submission_was_successful

  end

  def my_submissions
    set_meta_tags title: "my submissions"

    @open_submissions = []
    @closed_submissions = []

    if user_signed_in?

      Submission.where(email: current_user.email).each do |submission|
        if submission.status_for_author == "open"
          @open_submissions.push(submission)
        else
          @closed_submissions.push(submission)
        end
      end

    end



    #authorize @submissions
  end

  def searchable_list
    submission_search = SubmissionSearch.new(params[:search_input]["search_string"])
    @submissions = submission_search.search
  end

  def searchable_cards
    submission_search = SubmissionSearch.new(params[:search_input]["search_string"], params[:search_input]["selection"], params[:search_input][:user_id])
    @submissions = submission_search.search
  end

  # GET /submissions/new
  def new
    set_meta_tags title: "submit a paper to dialectica"

    @submission = Submission.new
  end

  def resubmit_submission
      original_submission = Submission.find(params[:id])
      new_submission = original_submission.dup
      new_submission.resubmit_original_dialectica_id = original_submission.dialectica_id
      @submission = new_submission
  end

  def iframe_new
    @submission = Submission.new
    response.headers["X-FRAME-OPTIONS"] = "ALLOW-FROM *"
    render layout: "application_iframe"
  end

  # GET /submissions/1/edit
  def edit
    authorize @submission
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)
    #@submission.history = @submission.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")}: </strong> #{current_user.firstname} #{current_user.lastname} created Submission</p>"
    #byebug

    if current_user.blank?
      #user = User.find_by_email("anonymous_user@mail.com")
    else
      user = current_user
      #@submission.submitted_by_user_id = user.id
    end

    @submission.email = @submission.email.downcase

    respond_to do |format|
      if @submission.save
        format.html {

          #SubmissionMailer.send_confirmation_for_submission(@submission.email, "Confirmation", "Confirmation", @submission).deliver_now

          params[:submission]["blocked_users"].reject!(&:blank?).each do |blocked_user|
            BlockedUser.create(user_id: blocked_user, submission_id: @submission.id)
          end

          @submission.set_dialectica_id


          if current_user.blank?

            if User.where(email: @submission.email).empty?
              password = SecureRandom.hex(3)
              username = User.create_uniq_username(@submission.lastname.parameterize)
              email = @submission.email

              author = User.create(username: username, email: @submission.email, password: password, password_confirmation: password, firstname: @submission.firstname, lastname: @submission.lastname)
              author.roles << Role.find_by_name("author")
              @submission.update(submitted_by_user_id: author.id)
              #.send_credentials(email, username, password).
              SubmissionMailer.send_confirmation_for_submission(@submission.email, "Confirmation", "Confirmation", @submission, author, password).deliver_now

              sign_in(:user, author)
              @submission.add_to_history(author, "submitted \"#{@submission.title}\"", "author")
            else
              SubmissionMailer.send_confirmation_for_submission(@submission.email, "Confirmation", "Confirmation", @submission, User.where(email: @submission.email).first).deliver_now
              @submission.add_to_history(User.find_by_email(@submission.email), "submitted \"#{@submission.title}\"", "author")
              redirect_to submission_was_successful_submissions_path, notice: 'submission was successfully created.' and return
              #redirect_to my_submissions_submissions_path, notice: 'submission was successfully created.' and return

            end
            #redirect_to show_for_user_submission_path(@submission), notice: 'submission was successfully created.' and return
            redirect_to my_submissions_submissions_path, notice: 'submission was successfully created.' and return

          else
            SubmissionMailer.send_confirmation_for_submission(@submission.email, "Confirmation", "Confirmation", @submission, current_user).deliver_now
            @submission.add_to_history(current_user, "submitted \"#{@submission.title}\"", "author")

            redirect_to my_submissions_submissions_path, notice: 'submission was successfully created.' and return

            #redirect_to @submission, notice: 'submission was successfully created.' and return
            #redirect_to show_for_user_submission_path(@submission), notice: 'submission was successfully created.' and return
          end



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
    authorize @submission
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
    authorize @submission
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submission_pool_url, notice: 'Submission was successfully deleted.'.downcase }
      format.json { head :no_content }
    end
  end

  def pool
    authorize Submission

    @histories = []

    History.order(:created_at).reverse.each do |history|
      unless current_user.blank? || history.submission.blank? || BlockedUser.where(user_id: current_user.id, submission_id: history.submission.id).present?
        @histories.push(history)
        break if @histories.length > 15
      end
    end

  end

  def pool_old
    authorize Submission
    @selection = params[:selection].present? ? params[:selection] : "all"

    #@submissions_without_reviewers = Submission.includes(:users).where( :users => { :id => nil } )
    @submissions_without_reviewers = Submission.alive.not_blacklisted(current_user).left_outer_joins(:users).where( users: { id: nil } )
    @submissions_with_reviewers = Submission.alive.not_blacklisted(current_user).where.not(id: @submissions_without_reviewers.pluck(:id))
    @submissions_with_one_reviewer = Submission.alive.not_blacklisted(current_user).where.not(id: @submissions_without_reviewers.pluck(:id))
    @submissions_suggested_to_me = Submission.alive.not_blacklisted(current_user).where(id: SuggestionSubmission.where(user_id: current_user.id).pluck(:submission_id))
    @proposed_submissions = Submission.alive.not_blacklisted(current_user).where(proposed_for_acceptance: "true")
    @submissions_proposed_for_acceptance = Submission.alive.not_blacklisted(current_user).where(proposed_for_acceptance: "true")
    @accepted_submissions = Submission.where(accepted: "true")
    @submissions_proposed_for_rejection = Submission.alive.not_blacklisted(current_user).where(proposed_for_rejection: "true")
    @rejected_submissions = Submission.where(rejected: "true")
    @dead_submissions = Submission.dead.not_blacklisted(current_user)
    @submissions_to_be_reviewed_by_me = current_user.submissions.alive.not_blacklisted(current_user)
    @all_submissions = Submission.not_blacklisted(current_user)
    @all_open_submissions = Submission.alive.not_blacklisted(current_user)

    if @selection == "without_reviewers"
      @submissions = @submissions_without_reviewers
    elsif @selection == "with_reviewers"
      @submissions = @submissions_with_reviewers
    elsif @selection == "by_me"
      @submissions = @submissions_to_be_reviewed_by_me
    elsif @selection == "all"
      @submissions = @all_submissions
    elsif @selection == "all_open"
      @submissions = @all_open_submissions
    elsif @selection == "suggested_to_me"
      @submissions = @submissions_suggested_to_me
    elsif @selection == "submissions_proposed_for_acceptance"
      @submissions = @submissions_proposed_for_acceptance
    elsif @selection == "accepted_submissions"
      @submissions = @accepted_submissions
    elsif @selection == "submissions_proposed_for_rejection"
      @submissions = @submissions_proposed_for_rejection
    elsif @selection == "rejected_submissions"
      @submissions = @rejected_submissions
    elsif @selection == "dead_submissions"
      @submissions = @dead_submissions
    end
    @submissions = @submissions.order(proposed: :desc, appearance_date: :desc)
    #@submissions.order(:appearance_date)
    #@submissions = Submission.all.order(:created_at)
    #@submissions.order(proposed: :asc, appearance_date: :desc)
    #submissions_with_reviewers = Submission.where.not(id: submissions_without_reviewers.pluck(:id))
  end

  def panel
    authorize Submission
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
    submission.add_to_history(current_user, comment, category: "comment")
    redirect_to submission_path(submission), notice: message
  end

  def add_me_to_blocked_users
    submission = Submission.find(params[:submission_id])
    blocked_user = BlockedUser.create(user_id: current_user.id, submission_id: submission.id)

    comment = "Blocked him- or herself from this submission".downcase
    message = "Blocking was successful".downcase
    submission.add_to_history(current_user, comment)
    redirect_to submission_pool_path, notice: message
  end



  def create_suggestion_to_user
    submission = Submission.find(params[:submission_id])
    SuggestionSubmission.create(user_id: params[:user_id], submission_id: submission.id)
    suggested_to_user = User.find(params[:user_id])
    #redirect_to submission_pool_path, notice: 'Suggestion added'
body =
"
Dear #{suggested_to_user.name}

The submission \"#{submission.title}\" has been suggested to you by #{current_user.name}.

Please visit: #{submission_url(submission)}
"
    # #{helpers.link_to submission.title, submission_url(submission)}
    SubmissionMailer.send_notification_of_suggestion(suggested_to_user, "dialectica - a submission has been suggested to you", body).deliver_now if suggested_to_user.notify_me_when_i_am_suggested_as_an_internal_referee == "yes"
    message = "suggested to #{User.find(params[:user_id]).name}"
    submission.add_to_history(current_user, message)
    #byebug
    redirect_to submission_path(params[:submission_id]), notice: 'Suggestion added'.downcase
  end

  def prolong_life
    submission = Submission.find(params[:id])
    submission.update(appearance_date: submission.appearance_date + 7.days)
    redirect_to submission_path(submission, notice: 'life prolonged'.downcase)

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

    if submission.extended_appearance_date_for_send_to_external_referee == "false"
      submission.update(appearance_date: submission.appearance_date + 31.days, extended_appearance_date_for_send_to_external_referee: "true")
    end
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

  def send_rejection_to_author_form

  end

  def send_rejection_to_author

    @subject = params[:submission][:subject]
    @body = params[:submission][:body]

    @sending_option = params[:send_directly]

    message = "sent rejection to author"

    @submission.add_to_history(current_user, message)
    @email = @submission.email

    @submission.update(dead: "true", rejected: "true")


    if params[:send_directly]
      SubmissionMailer.send_rejection_to_author(email: @email, subject: @subject, body: @body).deliver_now
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

  def propose_for_discussion
    submission = Submission.find(params[:id])
    submission.update(proposed_for_discussion: "true")
    message = "Proposed for Discussion".downcase
    submission.add_to_history(current_user, message)
    #redirect_to submission_path(submission), notice: 'Submission has been proposed'
    redirect_to submission_path(submission), notice: message
  end

  def unpropose_for_discussion
    submission = Submission.find(params[:id])
    submission.update(proposed_for_discussion: "false")
    message = "Unproposed for Discussion".downcase
    submission.add_to_history(current_user, message)
    #redirect_to submission_path(submission), notice: 'Submission has been proposed'
    redirect_to submission_path(submission), notice: message
  end

  def propose_for_acceptance
    submission = Submission.find(params[:id])
    submission.update(proposed_for_acceptance: "true")
    submission.add_to_history(current_user, "Proposed for Acceptance".downcase)
    #redirect_to submission_path(submission), notice: 'Submission has been proposed'
    redirect_to submission_path(params[:id]), notice: 'Proposed for Acceptance'.downcase
  end

  def unpropose_for_acceptance
    submission = Submission.find(params[:id])
    submission.update(proposed_for_acceptance: "false")
    submission.add_to_history(current_user, "Unproposed for Acceptance".downcase)
    #redirect_to submission_path(submission), notice: 'Submission has been proposed'
    redirect_to submission_path(params[:id]), notice: 'Unproposed for Acceptance'.downcase
  end

  def propose_for_rejection
    submission = Submission.find(params[:id])
    submission.update(proposed_for_rejection: "true")
    submission.add_to_history(current_user, "Proposed for Rejection".downcase)
    #redirect_to submission_path(submission), notice: 'Submission has been proposed'
    redirect_to submission_path(params[:id]), notice: 'Proposed for Rejection'.downcase
  end

  def unpropose_for_rejection
    submission = Submission.find(params[:id])
    submission.update(proposed_for_rejection: "false")
    submission.add_to_history(current_user, "Unproposed for Rejection".downcase)
    #redirect_to submission_path(submission), notice: 'Submission has been proposed'
    redirect_to submission_path(params[:id]), notice: 'Unproposed for Rejection'.downcase
  end

  def withdraw_submission
    submission = Submission.find(params[:id])
    submission.update(withdrawn: "true", dead: "true")
    user = User.where(email: submission.email).first


    SubmissionMailer.withdraw_submission_email(submission: submission, user: User.find_by_email(submission.email)).deliver_now

    submission.add_to_history(user, "withdrew Submission".downcase)
    redirect_to my_submissions_submissions_path, notice: 'Submission has been withdrawn'.downcase
  end

  def undo_withdraw_submission
    submission = Submission.find(params[:id])
    submission.update(withdrawn: "false", dead: "false")
    user = User.where(email: submission.email).first

    if user.blank?
      user = current_user
    end

    submission.add_to_history(user, "Submission not withdrawn anymore".downcase)
    redirect_to my_submissions_submissions_path, notice: 'Submission is not withdrawn anymore'.downcase
  end

  def withdraw_proposal_of_submission
    submission = Submission.find(params[:submission_id])
    submission.update(proposed: "false")
    submission.add_to_history(current_user, "Unproposed Submission".downcase)
    redirect_to submission_path(submission), notice: 'Submission proposal has been unproposed'.downcase
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
    #submission.update(appearance_date: Date.today)
    submission.update(appearance_date: submission.appearance_date + 31.days)

    message = "Submission resurrected".downcase
    submission.add_to_history(current_user, message)
    redirect_to submission_path(submission), notice: message
  end

  def accept_submission
    submission = Submission.find(params[:submission_id])
    submission.update(dead: "true", accepted: "true")
    message = "Submission accepted".downcase
    submission.add_to_history(current_user, message)
    redirect_to submission_path(submission), notice: message
  end

  def reject_submission
    submission = Submission.find(params[:submission_id])
    submission.update(dead: "true", rejected: "true")
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
    @submission.update(appearance_date: @submission.appearance_date + 7.days)

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
    @submission.update(appearance_date: @submission.appearance_date + 7.days)

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
      params.require(:submission).permit(:id, :title, :area, :firstname, :lastname, :file, :email, :history, :country, :gender, :other_authors, :attachments, :comment, :appearance_date, :submitted_by_user_id, :created_at, :accepted, :rejected, :withdrawn, :dead, :dialectica_id, :resubmit_original_dialectica_id)

    end
end
