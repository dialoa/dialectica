class ExternalRefereeSubmissionsController < ApplicationController
  before_action :set_external_referee_submission, only: [:show, :edit, :update, :destroy, :fast_update]

  # GET /external_referee_submissions
  # GET /external_referee_submissions.json
  def index
    @external_referee_submissions = ExternalRefereeSubmission.all
  end

  # GET /external_referee_submissions/1
  # GET /external_referee_submissions/1.json
  def show
  end

  # GET /external_referee_submissions/new
  def new
    @external_referee_submission = ExternalRefereeSubmission.new
  end

  # GET /external_referee_submissions/1/edit
  def edit
  end

  # POST /external_referee_submissions
  # POST /external_referee_submissions.json
  def create
    @external_referee_submission = ExternalRefereeSubmission.new(external_referee_submission_params)

    respond_to do |format|
      if @external_referee_submission.save
        format.html {
          redirect_to @external_referee_submission, notice: 'External referee submission was successfully created.'
        }
        format.json { render :show, status: :created, location: @external_referee_submission }
      else
        format.html { render :new }
        format.json { render json: @external_referee_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /external_referee_submissions/1
  # PATCH/PUT /external_referee_submissions/1.json
  def update
    respond_to do |format|
      if @external_referee_submission.update(external_referee_submission_params)
        format.html { redirect_to @external_referee_submission, notice: 'External referee submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @external_referee_submission }
      else
        format.html { render :edit }
        format.json { render json: @external_referee_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def fast_update
    submission = @external_referee_submission.submission
    @external_referee_submission.update(external_referee_submission_params)
    external_referee = @external_referee_submission.external_referee
    message = "external referee update: #{@external_referee_submission.status} - #{external_referee.name}"
    submission.add_to_history(current_user, message + " ")
  end

  def select_external_referee_for_form
    puts "PARAMS:"
    puts params
    puts params[:select_external_referee_for_form][:submission_id]
    @submission = Submission.find(params[:select_external_referee_for_form][:submission_id])
    @external_referee = ExternalReferee.find(params[:select_external_referee_for_form][:external_referee])
    #@submission = Submission.find(params[:submission_id])
  end

  def send_to_external_referee
    @submission = Submission.find(params[:submission_id])
  end

  # DELETE /external_referee_submissions/1
  # DELETE /external_referee_submissions/1.json
  def destroy
    @external_referee_submission.destroy
    respond_to do |format|
      format.html { redirect_to external_referee_submissions_url, notice: 'External referee submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_external_referee_submission
      @external_referee_submission = ExternalRefereeSubmission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def external_referee_submission_params
      #params.fetch(:external_referee_submission, {})
      params.require(:external_referee_submission).permit(:date_of_answer, :status)
    end
end
