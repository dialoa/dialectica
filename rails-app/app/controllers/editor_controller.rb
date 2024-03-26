require 'kramdown'
require 'fileutils'

class EditorController < ApplicationController

  def basic_markdown_editor
    if params[:inputs].present?
      @inputs = OpenStruct.new(params[:inputs])
      bibtexfile = params[:inputs][:bibtexfile]
      #byebug
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
bibliography: references.bib
header-includes:
  \paperheight = 29.70 cm  \paperwidth = 21.0 cm  \hoffset        = 0.46 cm
  \headheight  =  0.81 cm  \textwidth  = 15.0 cm  \evensidemargin = 0.00 cm
  \headsep     =  0.81 cm  \textheight = 9.00 in  \oddsidemargin  = 0.00 cm
---
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

    @inputs[:text] = @inputs[:text] ? @inputs[:text] : start_markdown
    @inputs[:references] = @inputs[:references] ? @inputs[:references] : start_references

    #markdown
    dir = Rails.root.join('public', 'basic_markdown_editor')
    Dir.mkdir(dir) unless Dir.exist?(dir)
    File.open(dir.join("basic_markdown_editor.md"), 'w+') do |file|
      file.write(@inputs[:text])
    end

    #references
    File.open(dir.join("references.bib"), 'w+') do |file|
      file.write(@inputs[:references])
      #if bibtex file is present
      unless bibtexfile.blank?
        file.write(File.read(bibtexfile))
        #file = params[:file]
      end
    end

    #output = `whoami`
    #puts "Who am i?"
    #puts output

    #output = `/usr/bin/pandoc -v`
    #puts "Pandoc Version:"
    #puts output

    Open3.popen3("pandoc -s -f markdown -t pdf #{dir}/basic_markdown_editor.md -C --bibliography=#{dir}/references.bib") do |stdin, stdout, stderr, wait_thr|
    #Open3.popen3("/usr/bin/pandoc -s -f markdown -t pdf #{dir}/basic_markdown_editor.md") do |stdin, stdout, stderr, wait_thr|
      #stdin.puts "This is sent to the command"
      #stdin.close                # we're done
      stdout_str = stdout.read   # read stdout to string. note that this will block until the command is done!
      #puts stdout_str
      #puts "Stdout_str:"
      #puts stdout_str
      file_to_store = Tempfile.new("basic-markdown-editor-#{Date.today.to_s}.pdf")
      file_to_store.write(stdout_str)
      file_to_store.rewind
      @stuff = Stuff.create(filename: "basic_markdown_editor #{DateTime.now}")
      @stuff.file.attach(io: file_to_store, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")
      file_to_store.close

      #stderr_str = stderr.read   # read stderr to string
      status = wait_thr.value    # will block until the command finishes; returns status that responds to .success? etc


      #output = `/usr/bin/pandoc -s -f markdown -t pdf /home/sandro/dialectica/public/basic_markdown_editor/basic_markdown_editor.md`
      #puts "full command:"
      #puts output

    end

    #`/usr/bin/pandoc -s -o #{dir}/basic_markdown_editor.pdf #{dir}/basic_markdown_editor.md`

    #File.delete("#{dir}/basic_markdown_editor.md")

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

    dir = Rails.root.join('public', 'pancritic')
    Dir.mkdir(dir) unless Dir.exist?(dir)
    File.open(dir.join("pancritic.md"), 'w+') do |file|
      file.write(@inputs[:text])
    end

    #Open3.popen3("pancritic -s -o #{dir}/pancritic.pdf #{dir}/pancritic.md") do |stdin, stdout, stderr, wait_thr|
    #  puts "popen3 popen3 popen3 popen3 popen3 popen3 popen3 popen3 popen3 popen3 popen3"
    #  stdin.puts "This is sent to the command"
    #  stdin.close                # we're done
    #  stdout_str = stdout.read   # read stdout to string. note that this will block until the command is done!
    #  puts stdout_str
    #  stderr_str = stderr.read   # read stderr to string
    #  puts stderr_str
    #  status = wait_thr.value    # will block until the command finishes; returns status that responds to .success? etc
    #  puts status
    #  puts dir
    #end

    #fork { exec("pancritic -s -o #{dir}/pancritic.pdf #{dir}/pancritic.md") }

    #system("pancritic -s -o #{dir}/pancritic.pdf #{dir}/pancritic.md")

    `pancritic -s -o #{dir}/pancritic.pdf #{dir}/pancritic.md`

    #%x(pancritic -s -o #{dir}/pancritic.pdf #{dir}/pancritic.md)

    #output = `/home/sandro/.local/bin/texlive/bin/x86_64-linux/pdflatex -v`
    #puts output

    until File.exist?("#{dir}/pancritic.pdf")
      sleep 1
    end

    File.open("#{dir}/pancritic.pdf") do |file|
      @stuff = Stuff.create(filename: "pancritic_editor #{DateTime.now}")
      @stuff.file.attach(io: file, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")
    end


    #File.delete("#{dir}/pancritic.md")
    #File.delete("#{dir}/pancritic.pdf")


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


  def basic_markdown_editor_old
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

    @stuff = Stuff.create(filename: "basic-markdown-editor #{DateTime.now}")

    dir = Rails.root.join('public', 'pandocin')
    Dir.mkdir(dir) unless Dir.exist?(dir)
    File.open(dir.join("pandoc.md"), 'w+') do |file|
      file.write(@inputs[:text])
    end

    pandoc_output = `pandoc -s -f markdown -t pdf #{dir}/pandoc.md`

    file_to_store = Tempfile.new('basic-markdown-editor-#{Date.today.to_s}.pdf')
    file_to_store.write(pandoc_output)
    file_to_store.rewind
    @stuff = Stuff.create(filename: "basic_markdown_editor #{DateTime.now}")
    @stuff.file.attach(io: file_to_store, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")
    file_to_store.close


    #system "pancritic -s -o #{dir}/pancritic.pdf #{dir}/pancritic.md"
    #system "pandoc -s -o #{dir}/pandoc.pdf #{dir}/pandoc.md"
    #pandoc_file = %x[pandoc -s -o #{dir}/pandoc.pdf #{dir}/pandoc.md]
    #byebug
    #@stuff.file.attach(io: pandoc_file, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")

    #File.open("#{dir}/pandoc.pdf") do |file|
    #  @stuff.file.attach(io: file, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")
    #end

    File.delete("#{dir}/pandoc.md")
    #File.delete("#{dir}/pandoc.pdf")



    #byebug

    #if @inputs[:text].blank?
    #  @result = PandocRuby.convert("Use Editor on the left.", :from => :markdown, :to => :pdf)
    #else
    #  @result = PandocRuby.convert(@inputs[:text], :from => :markdown, :to => :pdf)
    #end

    #file_to_store = Tempfile.new('basic-markdown-editor-#{Date.today.to_s}.pdf')
    #file_to_store.write(@result)
    #file_to_store.rewind
    #@stuff = Stuff.create(filename: "basic_markdown_editor #{DateTime.now}")
    #@stuff.file.attach(@result)
    #@stuff.file.attach(io: file_to_store, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")
    #file_to_store.close

  end

  def pancritic_editor_old
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

    #if @inputs[:text].blank?
    #  @result = PandocRuby.convert("Use Editor on the left.", :from => :markdown, :to => :pdf)
    #else
    #  @result = PandocRuby.convert(@inputs[:text], :from => :markdown, :to => :pdf)
    #end

    #file_to_store = Tempfile.new('basic-markdown-editor-#{Date.today.to_s}.pdf')
    #file_to_store.write(@result)
    #file_to_store.rewind
    @stuff = Stuff.create(filename: "pancritic_editor #{DateTime.now}")
    #@stuff.file.attach(@result)
    #@stuff.file.attach(io: file_to_store, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")
    #file_to_store.close

    dir = Rails.root.join('public', 'pancriticin')
    Dir.mkdir(dir) unless Dir.exist?(dir)
    File.open(dir.join("pancritic.md"), 'w+') do |file|
      file.write(@inputs[:text])
    end

    `pancritic -s -o #{dir}/pancritic.pdf #{dir}/pancritic.md`

    File.open("#{dir}/pancritic.pdf") do |file|
      @stuff.file.attach(io: file, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")
    end

    File.delete("#{dir}/pancritic.md")
    File.delete("#{dir}/pancritic.pdf")

    #file_to_store.close


  end
end
