class BibtexMailer < ApplicationMailer
  default from: 'dialecticaphilosophie@gmail.com'

  def bibtex_is_finished_email(email, stuff)
    @email = email
    @stuff = stuff
    @url_for_file = rails_blob_url(@stuff.file, disposition: "attachment")

    mail(to: email, subject: "Dialectica - your file is ready")

  end

end
