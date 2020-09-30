require 'kramdown'

class EditorController < ApplicationController
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
