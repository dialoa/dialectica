class EditorController < ApplicationController
  def editor
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new()
    end

    @search_inputs[:text] = @search_inputs[:text] ? @search_inputs[:text] : "It's very easy to make some words **bold**

and other words *italic* with Markdown.

You can even [link to Google!](http://google.com)"

    markdown_text = @search_inputs[:text]

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

    @result = markdown.render(markdown_text)
  end
end
