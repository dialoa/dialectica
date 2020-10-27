class AddManyToManyRelationshipGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  class_option :model, type: :string, default: ""

  def add_relationship
    @first_model = singular_table_name.capitalize
    @second_model = options['model'].capitalize
    @third_model_name = "#{@first_model.downcase}_#{@second_model.downcase.pluralize}"
    @timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    @camelcase = "CreateManyToManyRelationshipBetween#{@first_model}And#{@second_model}"

    template "migration.rb", "db/migrate/#{@timestamp}_#{@camelcase.underscore}.rb"

    #generate "scaffold", "#{singular_table_name.capitalize} title:string"
    #run "rails g migration AddSearchFieldTo#{plural_table_name.capitalize} search_field:text"
    #run "rails db:migrate"



    inject_into_file "app/models/#{@first_model.downcase.singularize}.rb", after: "class #{@first_model.capitalize} < ApplicationRecord\n" do <<-FILE
has_many :#{@third_model_name}
has_many :#{@second_model.downcase.pluralize}, :through => :#{@third_model_name}
FILE
    end

    inject_into_file "app/models/#{@second_model.downcase.singularize}.rb", after: "class #{@second_model.capitalize} < ApplicationRecord\n" do <<-FILE
has_many :#{@third_model_name}
has_many :#{@first_model.downcase.pluralize}, :through => :#{@third_model_name}
FILE
    end


    create_file "app/models/#{@third_model_name.singularize}.rb" do <<-FILE
class #{@third_model_name.singularize.camelize}  < ApplicationRecord
  belongs_to :#{@first_model.downcase.singularize}
  belongs_to :#{@second_model.downcase.singularize}
end
      FILE
    end


  end
end
