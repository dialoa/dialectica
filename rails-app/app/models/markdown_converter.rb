class MarkdownConverter
  def initialize(yaml, markdown, references, template)

    start_yaml ='
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

    @yaml = yaml || start_yaml
    @markdown = markdown || start_markdown
    @references = references || start_references
    @template = template || "galley"
  end

  def convert_markdown_to_pdf

    #markdown
    dir = Rails.root.join('public', 'basic_markdown_editor')
    Dir.mkdir(dir) unless Dir.exist?(dir)
    File.open(dir.join("basic_markdown_editor.md"), 'w+') do |file|
      file.write(create_yaml(@yaml, @template))
      file.write(@markdown)
    end

    #references
    File.open(dir.join("references.bib"), 'w+') do |file|
      #file.write(@references)
      file.write(@references.squish)
    end

    #convert
    Open3.popen3("pandoc -s -f markdown -t pdf #{dir}/basic_markdown_editor.md -C --bibliography=#{dir}/references.bib --pdf-engine=xelatex") do |stdin, stdout, stderr, wait_thr|
      stdout_str = stdout.read
      file_to_store = Tempfile.new("basic-markdown-editor-#{Date.today.to_s}.pdf")
      file_to_store.write(stdout_str)
      file_to_store.rewind
      @stuff = Stuff.create(filename: "basic_markdown_editor #{DateTime.now}", error: stderr.read)
      @stuff.file.attach(io: file_to_store, filename: "basic-markdown-editor-#{Date.today.to_s}.pdf")
      file_to_store.close
      status = wait_thr.value
      puts "STDERR FROM OPEN3"
      puts stderr.read
    end

    @stuff
  end

  def create_yaml(yaml, template)
    final_yaml = ""
    three_dashes ='
---
'

if template == "galley"
template ='
  fontfamily: lmodern,changes
  header-includes:
    \paperheight = 29.70 cm  \paperwidth = 21.0 cm  \hoffset        = 0.46 cm
    \headheight  =  0.81 cm  \textwidth  = 15.0 cm  \evensidemargin = 0.00 cm
    \headsep     =  0.81 cm  \textheight = 9.00 in  \oddsidemargin  = 0.00 cm
'
elsif template == "proof"
template ='
  fontfamily: lmodern,changes
  header-includes:
    \usepackage{lineno}
    \linenumbers
    \usepackage{draftwatermark}
    \SetWatermarkText{dialectica proof}
    \SetWatermarkScale{.7}
'

end

  final_yaml = three_dashes.chop + yaml.chop + template.chop + three_dashes.chop
  puts final_yaml
  final_yaml
  #byebug
  end

  def basic_markdown_editor
    if params[:inputs].present?
      @inputs = OpenStruct.new(params[:inputs])
      bibtexfile = params[:inputs][:bibtexfile]
      #byebug
    else
      @inputs = OpenStruct.new()
    end

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

end
