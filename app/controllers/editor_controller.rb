require 'kramdown'

class EditorController < ApplicationController

  def basic_markdown_editor
    if params[:inputs].present?
      @inputs = OpenStruct.new(params[:inputs])
    else
      @inputs = OpenStruct.new()
    end

    @inputs[:text] = @inputs[:text] ? @inputs[:text] : "Enter text here"
    #byebug

    if @inputs[:text].blank?
      @result = PandocRuby.convert("Use Editor on the left.", :from => :markdown, :to => :pdf)
    else
      @result = PandocRuby.convert(@inputs[:text], :from => :markdown, :to => :pdf)
    end

    file_to_store = Tempfile.new('basic-markdown-editor-#{Date.today.to_s}.pdf')
    file_to_store.write(@result)
    file_to_store.rewind
    @stuff = Stuff.create(filename: "basic_markdown_editor #{DateTime.now}")
    #@stuff.file.attach(@result)
    @stuff.file.attach(io: file_to_store, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")
    file_to_store.close


  end

  def editor

    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new()
    end

    @search_inputs[:text] = @search_inputs[:text] ? @search_inputs[:text] : "<h1>Title</h1>
<p>Normal</p>
<p><em>Italic</em></p>
<p><strong>Bold</strong></p>
<h2>List</h2>
<ul>
<li>a</li>
<li>b</li>
<li>c</li>
<li>d</li>
</ul>"

    markdown_text = @search_inputs[:text]

    @markdown_text = Kramdown::Document.new(' <h1 id="header">Header</h1> <p>This is <span style="color: red">written in red</span>.</p>').to_kramdown

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

    @result = markdown.render(markdown_text)

    #@result = Kramdown::Document.new(markdown_text).to_html

  end
end
