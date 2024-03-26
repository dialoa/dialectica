class RequestedReviewersController < ApplicationController
  before_action :set_requested_reviewer, only: [:show, :edit, :update, :destroy]

  # GET /requested_reviewers
  # GET /requested_reviewers.json
  def index
    @requested_reviewers = RequestedReviewer.all
  end

  # GET /requested_reviewers/1
  # GET /requested_reviewers/1.json
  def show
  end

  # GET /requested_reviewers/new
  def new
    @requested_reviewer = RequestedReviewer.new
  end

  # GET /requested_reviewers/1/edit
  def edit
  end

  # POST /requested_reviewers
  # POST /requested_reviewers.json
  def create
    @requested_reviewer = RequestedReviewer.new(requested_reviewer_params)

    respond_to do |format|
      if @requested_reviewer.save
        format.html { redirect_to @requested_reviewer, notice: 'Requested reviewer was successfully created.' }
        format.json { render :show, status: :created, location: @requested_reviewer }
      else
        format.html { render :new }
        format.json { render json: @requested_reviewer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requested_reviewers/1
  # PATCH/PUT /requested_reviewers/1.json
  def update
    respond_to do |format|
      if @requested_reviewer.update(requested_reviewer_params)
        format.html { redirect_to @requested_reviewer, notice: 'Requested reviewer was successfully updated.' }
        format.json { render :show, status: :ok, location: @requested_reviewer }
      else
        format.html { render :edit }
        format.json { render json: @requested_reviewer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requested_reviewers/1
  # DELETE /requested_reviewers/1.json
  def destroy
    @requested_reviewer.destroy
    respond_to do |format|
      format.html { redirect_to requested_reviewers_url, notice: 'Requested reviewer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requested_reviewer
      @requested_reviewer = RequestedReviewer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def requested_reviewer_params
      params.require(:requested_reviewer).permit(:firstname, :lastname, :email, :status)
    end
end
