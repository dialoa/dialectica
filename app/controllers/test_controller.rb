class TestController < ApplicationController
  if Rails.env.development?
    def destroy_all_submissions
      Submission.all.destroy_all
    end

    def destroy_all_users
      User.all.destroy_all

      admin = User.create(username: "admin", email: "admin@gmail.com", password: "epikur", password_confirmation: "epikur", firstname: "Admin", lastname: "Admin")
      admin.roles << Role.find_by_name("admin")
      admin.roles << Role.find_by_name("editor")
      admin.roles << Role.find_by_name("reviewer")
      admin.roles << Role.find_by_name("author")

      editor = User.create(username: "editor", email: "editor@gmail.com", password: "epikur", password_confirmation: "epikur", firstname: "Editor", lastname: "Editor")
      editor.roles << Role.find_by_name("editor")
      editor.roles << Role.find_by_name("reviewer")
      editor.roles << Role.find_by_name("author")

      reviewer = User.create(username: "reviewer", email: "reviewer@gmail.com", password: "epikur", password_confirmation: "epikur", firstname: "Reviewer", lastname: "Reviewer")
      reviewer.roles << Role.find_by_name("reviewer")
      reviewer.roles << Role.find_by_name("author")

      author = User.create(username: "author", email: "author@gmail.com", password: "epikur", password_confirmation: "epikur", firstname: "Author", lastname: "Author")
      author.roles << Role.find_by_name("author")

      anonymous_user = User.create(username: "anonymous_user", email: "anonymous_user@gmail.com", password: "epikur", password_confirmation: "epikur", firstname: "Anonymous", lastname: "User")
      anonymous_user.roles << Role.find_by_name("author")
      
    end

    def destroy_all_external_referees
      ExternalReferee.all.destroy_all
    end
  end
end
