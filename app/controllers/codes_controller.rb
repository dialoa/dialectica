class CodesController < ApplicationController
  before_action :set_code, only: [:show, :edit, :update, :destroy, :editor, :update_editor, :download]
  before_action :authenticate_user!, only: [:my_codes]
  require 'zip'
  # GET /codes
  # GET /codes.json
  def index
    @codes = Code.all
  end

  # GET /codes/1
  # GET /codes/1.json
  def show
    #@stuff = MarkdownConverter.new(@code.content, "").convert_markdown_to_pdf
  end

  def my_codes
    @codes = current_user.codes
  end

  def editor
    template = "galley"

    if params[:inputs].present?
      bibtex = ""
      bibtex = params[:inputs][:bibtex] if params[:inputs][:bibtex].present?
      bibtex = bibtex + File.read(params[:inputs][:bibtexfile]) if params[:inputs][:bibtexfile].present?
      #byebug
      @code.update(bibtex: bibtex)
      @code.update(content: params[:inputs][:text]) if params[:inputs][:text].present?
      @code.update(yaml: params[:inputs][:yaml]) if params[:inputs][:yaml].present?
      @code.update(name: params[:inputs][:name]) if params[:inputs][:name].present?
      template = params[:inputs][:template] if params[:inputs][:template].present?
    end

    @stuff = MarkdownConverter.new(@code.yaml, @code.content, @code.bibtex, template).convert_markdown_to_pdf
  end

  def update_editor
    template = "galley"

    if params[:inputs].present?
      bibtex = ""
      bibtex = params[:inputs][:bibtex] if params[:inputs][:bibtex].present?
      bibtex = bibtex + File.read(params[:inputs][:bibtexfile]) if params[:inputs][:bibtexfile].present?
      #byebug
      @code.update(bibtex: bibtex)
      @code.update(content: params[:inputs][:text]) if params[:inputs][:text].present?
      @code.update(yaml: params[:inputs][:yaml]) if params[:inputs][:yaml].present?
      @code.update(name: params[:inputs][:name]) if params[:inputs][:name].present?
      template = params[:inputs][:template] if params[:inputs][:template].present?
    end

    @stuff = MarkdownConverter.new(@code.yaml, @code.content, @code.bibtex, template).convert_markdown_to_pdf

    render "codes/update_editor.js.erb"
  end

  def create_new_code_for_user

    start_yaml =
'
  title: Logic and Metaphysics
  author: John Myers
  date: May 9, 2020
'

    start_markdown ='
# Introduction

If a then b [@Brouwer_1954]

## Models of Language

*italics* and _italics_
**bold** and __bold__
***bold it.*** and ___bold it.___

```
this is
a
code block
```
 ![Random Picture](https://i.picsum.photos/id/1041/5184/2916.jpg?hmac=TW_9o6HeD7H7I7NVo-S1Fa1iAvzQ10uvmJqsXvNoi0M)

'

start_references ='
@article{Brouwer_1954,
  doi = {10.4153/cjm-1954-001-9},
  url = {https://doi.org/10.4153%2Fcjm-1954-001-9},
  year = 1954,
  publisher = {Canadian Mathematical Society},
  volume = {6},
  pages = {1--17},
  author = {L. E. J. Brouwer},
  title = {Points and Spaces},
  journal = {Canadian Journal of Mathematics}
}

'
  @code = Code.create(name: "Markdown - #{DateTime.now.strftime("%d/%m/%Y %H:%M")}", content: start_markdown, bibtex: start_references, yaml: start_yaml)
  unless current_user.blank?
    current_user.codes << @code unless current_user.codes.include?(@code)
  end
  redirect_to codes_editor_path(@code)
  end

  def editor_save

  end

  def download
    compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      zos.put_next_entry "#{@code.name}".parameterize + ".md"
      zos.write @code.content

      zos.put_next_entry "#{@code.name}".parameterize + ".bib"
      zos.write @code.bibtex
    end

    compressed_filestream.rewind
    send_data compressed_filestream.read, filename: "#{@code.name}.zip"
  end

  # GET /codes/new
  def new
    @code = Code.new
  end

  # GET /codes/1/edit
  def edit
  end

  # POST /codes
  # POST /codes.json
  def create
    @code = Code.new(code_params)

    respond_to do |format|
      if @code.save
        format.html { redirect_to @code, notice: 'Code was successfully created.' }
        format.json { render :show, status: :created, location: @code }
      else
        format.html { render :new }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codes/1
  # PATCH/PUT /codes/1.json
  def update
    respond_to do |format|
      if @code.update(code_params)
        format.html { redirect_to @code, notice: 'Code was successfully updated.' }
        format.json { render :show, status: :ok, location: @code }
      else
        format.html { render :edit }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codes/1
  # DELETE /codes/1.json
  def destroy
    @code.destroy
    respond_to do |format|
      format.html { redirect_to codes_url, notice: 'Code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code
      @code = Code.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def code_params
      params.require(:code).permit(:content, :bibtex, :name, :yaml)
    end
end
