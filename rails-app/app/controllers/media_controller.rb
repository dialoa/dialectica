class MediaController < ApplicationController
  before_action :set_medium, only: %i[ show edit update destroy ]

  # GET /media or /media.json
  def index
    @media = Medium.all
  end

  # GET /media/1 or /media/1.json
  def show
  end

  # GET /media/new
  def new
    @medium = Medium.new
  end

  # GET /media/1/edit
  def edit
  end

  # POST /media or /media.json
  def create

    @medium = Medium.new(medium_params)

    respond_to do |format|
      if @medium.save
        format.html { redirect_to @medium, notice: "Medium was successfully created." }
        format.json { render :show, status: :created, location: @medium }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_for_submission

    @medium = Medium.new(medium_params)

    respond_to do |format|
      if @medium.save
        format.html {
          link = helpers.link_to("#{@medium.file.filename}", rails_blob_path(@medium.file, disposition: "attachment"))
          message = "Uploaded a file:<br>"+ link + " <br> #{@medium.comment}"
          @medium.mediumable.add_to_history(current_user, message)
          redirect_to @medium.mediumable, notice: "Medium was successfully created."
        }
        format.json {
          link = helpers.link_to("#{@medium.file.filename}", rails_blob_path(@medium.file, disposition: "attachment"))
          message = "Uploaded a file: <br><br>"+ link + " <br> #{@medium.comment}"
          @medium.mediumable.add_to_history(current_user, message)
          render :show, status: :created, location: @medium.mediumable
        }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media/1 or /media/1.json
  def update
    respond_to do |format|
      if @medium.update(medium_params)
        format.html { redirect_to @medium, notice: "Medium was successfully updated." }
        format.json { render :show, status: :ok, location: @medium }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1 or /media/1.json
  def destroy
    @medium.destroy
    respond_to do |format|
      format.html { redirect_to media_url, notice: "Medium was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medium
      @medium = Medium.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def medium_params
      params.require(:medium).permit(:comment, :mediumable_id, :mediumable_type, :file)
    end
end
