class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :latex, :pdf, :plain,:markdown]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    respond_to do |format|
      format.html  # index.html.erb
      format.pdf
      #format.tex  { render plain: @article.latex }
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def latex
    if @article.latex.blank?
      text = PandocRuby.html(@article.content, :standalone).to_latex
    else
      text = @article.latex
    end
    render plain: text
  end

  def plain
    text = PandocRuby.html(@article.content, :standalone).to_plain
    render plain: text
  end

  def markdown
    text = PandocRuby.html(@article.content, :standalone).to_markdown
    render plain: text
  end

  def markdown
    text = PandocRuby.html(@article.content, :standalone).to_markdown
    render plain: text
  end

  def pdf
    #pdf = PandocRuby.html(@article.content, :standalone).to_pdf
    #pdf_string = PandocRuby.convert(@article.content, :from => :html, :to => :pdf)
    #raw_pdf_string = Base64.decode64 pdf_string
    #render :text, raw_pdf_string
    #html = @article.content
    #pdf = WickedPdf.new.pdf_from_string(html)

    send_data render_to_string(
                            pdf: "document.pdf",
                            inline: "<!doctype html><html><head></head><body>#{@article.content}</body></html>",
                            dpi: 75), filename: "document.pdf", disposition: 'inline'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:author, :content, :title, :published_at, :latex, :format, :description, :keywords, :status)
    end
end
