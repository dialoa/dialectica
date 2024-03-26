class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /histories
  # GET /histories.json
  def index
    #@histories = History.all

    @histories = HistorySearch.new(current_user: current_user).search

  end

  # GET /histories/1
  # GET /histories/1.json
  def show
  end

  # GET /histories/new
  def new
    @history = History.new
  end

  # GET /histories/1/edit
  def edit
  end

  # POST /histories
  # POST /histories.json
  def create
    @history = History.new(history_params)

    respond_to do |format|
      if @history.save
        format.html { redirect_to @history, notice: 'History was successfully created.' }
        format.json { render :show, status: :created, location: @history }
      else
        format.html { render :new }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  def update
    respond_to do |format|
      if @history.update(history_params)
        format.html { redirect_to submission_path(@history.submission), notice: 'History was successfully updated.' }
        format.json { render :show, status: :ok, location: @history }
      else
        format.html { render :edit }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history.destroy
    respond_to do |format|
      format.html { redirect_to submission_pool_url, notice: 'History was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def searchable_list_histories
    @histories = HistorySearch.new(
      search_string: params[:search_input][:search_string],
      submission: params[:search_input][:submission_id].present? ? Submission.find(params[:search_input][:submission_id]) : nil,
      user: params[:search_input][:user_id].present? ? User.find(params[:search_input][:user_id]) : nil,
      current_user: current_user
     ).search
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def history_params
      params.require(:history).permit(:content, :alternative_name, :category)
    end
end
