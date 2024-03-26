class WebSiteContentsController < ApplicationController
  before_action :set_web_site_content, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show]


  # GET /web_site_contents or /web_site_contents.json
  def index
    authorize WebSiteContent

    @web_site_contents = WebSiteContent.all
  end

  # GET /web_site_contents/1 or /web_site_contents/1.json
  def show
    authorize @web_site_content
  end

  # GET /web_site_contents/new
  def new
    @web_site_content = WebSiteContent.new
    authorize @web_site_content

  end

  # GET /web_site_contents/1/edit
  def edit
    authorize @web_site_content

  end

  # POST /web_site_contents or /web_site_contents.json
  def create
    @web_site_content = WebSiteContent.new(web_site_content_params)
    authorize @web_site_content

    respond_to do |format|
      if @web_site_content.save
        format.html { redirect_to @web_site_content, notice: "Web site content was successfully created." }
        format.json { render :show, status: :created, location: @web_site_content }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @web_site_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /web_site_contents/1 or /web_site_contents/1.json
  def update
    authorize @web_site_content

    respond_to do |format|
      if @web_site_content.update(web_site_content_params)
        format.html { redirect_to @web_site_content, notice: "Web site content was successfully updated." }
        format.json { render :show, status: :ok, location: @web_site_content }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @web_site_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /web_site_contents/1 or /web_site_contents/1.json
  def destroy
    authorize @web_site_content

    @web_site_content.destroy
    respond_to do |format|
      format.html { redirect_to web_site_contents_url, notice: "Web site content was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_web_site_content
      @web_site_content = WebSiteContent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def web_site_content_params
      params.require(:web_site_content).permit(:title, :content, :identifier)
    end
end
