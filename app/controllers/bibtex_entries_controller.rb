class BibtexEntriesController < ApplicationController
  before_action :set_bibtex_entry, only: [:show, :edit, :update, :destroy]

  # GET /bibtex_entries
  # GET /bibtex_entries.json
  def index
    @bibtex_entries = BibtexEntry.all
  end

  # GET /bibtex_entries/1
  # GET /bibtex_entries/1.json
  def show
  end

  # GET /bibtex_entries/new
  def new
    @bibtex_entry = BibtexEntry.new
  end

  # GET /bibtex_entries/1/edit
  def edit
  end

  # POST /bibtex_entries
  # POST /bibtex_entries.json
  def create
    @bibtex_entry = BibtexEntry.new(bibtex_entry_params)

    respond_to do |format|
      if @bibtex_entry.save
        format.html { redirect_to @bibtex_entry, notice: 'Bibtex entry was successfully created.' }
        format.json { render :show, status: :created, location: @bibtex_entry }
      else
        format.html { render :new }
        format.json { render json: @bibtex_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bibtex_entries/1
  # PATCH/PUT /bibtex_entries/1.json
  def update
    respond_to do |format|
      if @bibtex_entry.update(bibtex_entry_params)
        format.html { redirect_to @bibtex_entry, notice: 'Bibtex entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @bibtex_entry }
      else
        format.html { render :edit }
        format.json { render json: @bibtex_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bibtex_entries/1
  # DELETE /bibtex_entries/1.json
  def destroy
    @bibtex_entry.destroy
    respond_to do |format|
      format.html { redirect_to bibtex_entries_url, notice: 'Bibtex entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bibtex_entry
      @bibtex_entry = BibtexEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bibtex_entry_params
      params.require(:bibtex_entry).permit(:content)
    end
end
