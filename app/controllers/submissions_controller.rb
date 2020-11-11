class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy, :panel]
  before_action :authenticate_user!, only: [:my_submissions]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
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
    @submission.history = @submission.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")}: </strong> #{current_user.firstname} #{current_user.lastname} created Submission</p>"

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
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
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
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

    @submissions_without_reviewers = Submission.left_outer_joins(:users).where( users: { id: nil } )
    @submissions_with_reviewers = Submission.where.not(id: @submissions_without_reviewers.pluck(:id)).order(:created_at)

    if @selection == "without_reviewers"
      @submissions = @submissions_without_reviewers.order(:created_at)
    elsif @selection == "with_reviewers"
      @submissions = @submissions_with_reviewers
    elsif @selection == "by_me"
      @submissions = current_user.submissions.order(:created_at)
    elsif @selection == "all"
      @submissions = Submission.all.order(:created_at)
    elsif @selection == "suggested_to_me"
      @submissions = Submission.all.order(:created_at)
    end
    #@submissions = Submission.all.order(:created_at)

    #submissions_with_reviewers = Submission.where.not(id: submissions_without_reviewers.pluck(:id))
  end

  def panel

  end

  def add_user_to_submission
    @user = User.find(params[:user_id])
    @submission = Submission.find(params[:submission_id])
    @user.submissions << @submission if @user.submissions.where(id: @submission.id).empty?

    @submission.update(history: @submission.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")}: </strong> #{current_user.firstname} #{current_user.lastname} signed up as Internal Referee</p>")

    redirect_to submission_pool_path, notice: 'Submission was added to your Profile'
  end

  def remove_user_from_submission
    @user = User.find(params[:user_id])
    @submission = Submission.find(params[:submission_id])
    @user.submissions.delete(@submission)
    #@user.submissions << @submission if @user.submissions.where(id: @submission.id).empty?

    @submission.update(history: @submission.history + "<p><strong>#{Date.today.strftime("%d.%m.%Y")}: </strong> #{current_user.firstname} #{current_user.lastname} quit as Internal Referee</p>")

    redirect_to submission_pool_path, notice: 'Submission was removd from your Profile'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:title, :area, :firstname, :lastname, :file, :email, :history)
    end
end
