class EditorController < ApplicationController
  def editor
    if params[:search_inputs].present?
      @search_inputs = OpenStruct.new(params[:search_inputs])
    else
      @search_inputs = OpenStruct.new()
    end

    @search_inputs[:text] = @search_inputs[:text] ? @search_inputs[:text] : "It's very easy to make some words **bold**

and other words *italic* with Markdown.

You can even [link to Google!](http://google.com)

# h1 Heading

+ Create a list by starting a line with `+`, `-`, or `*`
  + Sub-lists are made by indenting 2 spaces:
    - Marker character change forces new list start:
      * Ac tristique libero volutpat at
      + Facilisis in pretium nisl aliquet
      - Nulla volutpat aliquam velit

  > This is a blockquote"

    markdown_text = @search_inputs[:text]

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

    @result = markdown.render(markdown_text)
  end
end
