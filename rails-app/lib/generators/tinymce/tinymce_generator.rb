class TinymceGenerator < Rails::Generators::NamedBase

  class_option :name_of_attribute, type: :string, default: 'content'

  def add_gem
    gem "tinymce-rails"
    gem "sanitize"
    run "bundle install"
  end

  def create_config_file
    create_file "config/tinymce.yml", <<-FILE
menubar: false
toolbar:
  - styleselect | bold italic | undo redo | link | table | code | alignleft | aligncenter | alignjustify
plugins:
  - link
  - table
  - code
      FILE
    end

    def change_form_file
      @name_of_attribute = options['name_of_attribute']
      gsub_file "app/views/#{plural_table_name}/_form.html.erb", "<%= f.input :#{@name_of_attribute} %>", "<%= f.text_area :#{@name_of_attribute}, :class => \"tinymce\", :rows => 40, :cols => 120 %>"

      append_to_file "app/views/#{plural_table_name}/_form.html.erb" do
        "<%= tinymce_assets %> \n <%= tinymce %>"
      end
    end

    def change_view_file
      @name_of_attribute = options['name_of_attribute']
      #gsub_file "app/views/#{plural_table_name}/_show.html.erb", "<%= #{singular_table_name}.#{@name_of_attribute} %>", "<%= raw Sanitize.fragment(#{singular_table_name}.#{@name_of_attribute}, Sanitize::Config::RELAXED) %>"
      gsub_file "app/views/#{plural_table_name}/_show.html.erb", "<%= #{singular_table_name}.#{@name_of_attribute} %>", "<%= raw sanitizing(#{singular_table_name}.#{@name_of_attribute}) %>"
      #    <%= raw sanitizing(#{singular_table_name}.#{@name_of_attribute}) %>

    end

  end
