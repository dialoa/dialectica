# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.roles.each do |role|
  Role.create(name: role)
end

admin = User.create(email: "admin@mail.com", password: "epikur", password_confirmation: "epikur", firstname: "Admin", lastname: "Admin")
admin.roles << Role.find_by_name("admin")
admin.roles << Role.find_by_name("editor")
admin.roles << Role.find_by_name("reviewer")
admin.roles << Role.find_by_name("author")

editor = User.create(email: "editor@mail.com", password: "epikur", password_confirmation: "epikur", firstname: "Editor", lastname: "Editor")
editor.roles << Role.find_by_name("editor")
editor.roles << Role.find_by_name("reviewer")
editor.roles << Role.find_by_name("author")

reviewer = User.create(email: "reviewer@mail.com", password: "epikur", password_confirmation: "epikur", firstname: "Reviewer", lastname: "Reviewer")
reviewer.roles << Role.find_by_name("reviewer")
reviewer.roles << Role.find_by_name("author")

author = User.create(email: "author@mail.com", password: "epikur", password_confirmation: "epikur", firstname: "Author", lastname: "Author")
author.roles << Role.find_by_name("author")
