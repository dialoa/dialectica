class BibtexFilesController < ApplicationController
  before_action :set_bibtex_file, only: [:show, :edit, :update, :destroy]

  # GET /bibtex_files
  # GET /bibtex_files.json
  def index
    @bibtex_files = BibtexFile.all
  end

  # GET /bibtex_files/1
  # GET /bibtex_files/1.json
  def show
  end

  # GET /bibtex_files/new
  def new
    @bibtex_file = BibtexFile.new
  end

  # GET /bibtex_files/1/edit
  def edit
  end

  # POST /bibtex_files
  # POST /bibtex_files.json
  def create
    @bibtex_file = BibtexFile.new(bibtex_file_params)

    respond_to do |format|
      if @bibtex_file.save
        format.html { redirect_to @bibtex_file, notice: 'Bibtex file was successfully created.' }
        format.json { render :show, status: :created, location: @bibtex_file }
      else
        format.html { render :new }
        format.json { render json: @bibtex_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bibtex_files/1
  # PATCH/PUT /bibtex_files/1.json
  def update
    respond_to do |format|
      if @bibtex_file.update(bibtex_file_params)
        format.html { redirect_to @bibtex_file, notice: 'Bibtex file was successfully updated.' }
        format.json { render :show, status: :ok, location: @bibtex_file }
      else
        format.html { render :edit }
        format.json { render json: @bibtex_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bibtex_files/1
  # DELETE /bibtex_files/1.json
  def destroy
    @bibtex_file.destroy
    respond_to do |format|
      format.html { redirect_to bibtex_files_url, notice: 'Bibtex file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bibtex_file
      @bibtex_file = BibtexFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bibtex_file_params
      params.require(:bibtex_file).permit(:content)
    end
end
