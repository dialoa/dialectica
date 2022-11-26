class ExternalRefereesController < ApplicationController
  before_action :set_external_referee, only: [:show, :edit, :update, :destroy]

  # GET /external_referees
  # GET /external_referees.json
  def index
    @external_referees = ExternalReferee.all
  end

  # GET /external_referees/1
  # GET /external_referees/1.json
  def show
  end

  # GET /external_referees/new
  def new
    @external_referee = ExternalReferee.new
  end

  # GET /external_referees/1/edit
  def edit
  end

  # POST /external_referees
  # POST /external_referees.json
  def create
    @external_referee = ExternalReferee.new(external_referee_params)

    respond_to do |format|
      if @external_referee.save
        format.html { redirect_to @external_referee, notice: 'External referee was successfully created.' }
        format.json { render :show, status: :created, location: @external_referee }
      else
        format.html { render :new }
        format.json { render json: @external_referee.errors, status: :unprocessable_entity }
      end
    end
  end

  def fast_create
    #add history entry
    @external_referee = ExternalReferee.create(external_referee_params)
    @submission = Submission.find(params[:submission_id])
    flash[:notice] = "external referee has been added"
    redirect_to send_to_external_referee_external_referee_submissions_path(@submission)
    #@external_referee_submission.update(external_referee_submission_params)
  end

  # PATCH/PUT /external_referees/1
  # PATCH/PUT /external_referees/1.json
  def update
    respond_to do |format|
      if @external_referee.update(external_referee_params)
        format.html { redirect_to @external_referee, notice: 'External referee was successfully updated.' }
        format.json { render :show, status: :ok, location: @external_referee }
      else
        format.html { render :edit }
        format.json { render json: @external_referee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /external_referees/1
  # DELETE /external_referees/1.json
  def destroy
    @external_referee.destroy
    respond_to do |format|
      format.html { redirect_to external_referees_url, notice: 'External referee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_external_referee
      @external_referee = ExternalReferee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def external_referee_params
      params.require(:external_referee).permit(:firstname, :lastname, :email)
    end
end
