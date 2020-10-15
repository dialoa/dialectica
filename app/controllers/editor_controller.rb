require 'kramdown'
require 'fileutils'

class EditorController < ApplicationController

  def basic_markdown_editor
    if params[:inputs].present?
      @inputs = OpenStruct.new(params[:inputs])
    else
      @inputs = OpenStruct.new()
    end

    start_markdown ='
---
title: Logic and Metaphysics
shorttitle: What is the connection between language and being?
author: Sandro Räss
date: May 9, 2020
fontfamily: lmodern,changes
header-includes:
  \paperheight = 29.70 cm  \paperwidth = 21.0 cm  \hoffset        = 0.46 cm
  \headheight  =  0.81 cm  \textwidth  = 15.0 cm  \evensidemargin = 0.00 cm
  \headsep     =  0.81 cm  \textheight = 9.00 in  \oddsidemargin  = 0.00 cm
---
# Introduction

If a then b

## Models of Language

*italics* and _italics_
**bold** and __bold__
***bold it.*** and ___bold it.___

```
this is
a
code block
```


'

    @inputs[:text] = @inputs[:text] ? @inputs[:text] : start_markdown
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

  def pancritic_editor
    if params[:inputs].present?
      @inputs = OpenStruct.new(params[:inputs])
    else
      @inputs = OpenStruct.new()
    end

    start_markdown ='
---
title: Test CriticMarkup with pandoc
author: Kolen Cheung
fontfamily: lmodern,changes
header-includes:
  \usepackage{lineno}
  \linenumbers
  \usepackage{draftwatermark}
  \SetWatermarkText{dialectica proof}
  \SetWatermarkScale{.7}
---

Cum sociis natoquel {--penatibus et magnis--}{>>FTP - 2013-05-13 08:20:18<<} dis parturient montes, nascetur ridiculus mus. Praesent et tellus in eros {++cunning ++}{>>FTP - 2013-05-13 08:20:22<<}eleifend imperdiet non at magna. Nunc aliquam accumsan auctor. In vitae mi sapien. Ut eget pretium purus. {~~Proin~>Prawn~~}{>>FTP - 2013-05-13 08:20:29<<} condimentum hendrerit risus quis tristique. Cras fermentum, diam id sodales feugiat, arcu risus imperdiet nisi, sit amet consequat diam lectus id mi. Cras varius convallis turpis, in iaculis mi cursus vitae. Nulla dignissim aliquet nulla, eu pulvinar nunc fringilla ut. Nullam {==condimentum tortor==}{>>Huh?<<} eu quam tempor tempus. Quisque sit amet magna nec nisl mollis varius a nec ligula. Sed adipiscing, est in gravida sagittis, elit sapien vestibulum quam, a {>>Test comment.<<}tristique arcu eros nec enim. Morbi euismod velit eget ligula faucibus quis feugiat massa fermentum. In velit tellus, pretium ac posuere ac, ultrices eget magna.

1. {++This is an *addition*.++}
2. {--This was a *deletion*.--}
3. This {~~*was*~>*is*~~} a substitution.
4. This is a {==*highlight*==}{>> With a *comment* that should not appear.<<}.
5. This is a {==*highlight*==} without comment.
'


    @inputs[:text] = @inputs[:text] ? @inputs[:text] : start_markdown
    #byebug

    if @inputs[:text].blank?
      @result = PandocRuby.convert("Use Editor on the left.", :from => :markdown, :to => :pdf)
    else
      @result = PandocRuby.convert(@inputs[:text], :from => :markdown, :to => :pdf)
    end

    #file_to_store = Tempfile.new('basic-markdown-editor-#{Date.today.to_s}.pdf')
    #file_to_store.write(@result)
    #file_to_store.rewind
    @stuff = Stuff.create(filename: "basic_markdown_editor #{DateTime.now}")
    #@stuff.file.attach(@result)
    #@stuff.file.attach(io: file_to_store, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")
    #file_to_store.close

    dir = Rails.root.join('public', 'pancriticin')
    Dir.mkdir(dir) unless Dir.exist?(dir)
    File.open(dir.join("pancritic.md"), 'w+') do |file|
      file.write(@inputs[:text])
    end

    system "pancritic -s -o #{dir}/pancritic.pdf #{dir}/pancritic.md"

    File.open("#{dir}/pancritic.pdf") do |file|
      @stuff.file.attach(io: file, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")
    end

    File.delete("#{dir}/pancritic.md")
    File.delete("#{dir}/pancritic.pdf")


    #file_to_store.close


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
