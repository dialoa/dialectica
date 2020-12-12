class SubmissionMailer < ApplicationMailer
  default from: 'dialecticaphilosophie@gmail.com'

  def send_to_external_referee(email, subject, body, current_user)

    @email = email
    @subject = subject
    @body = body
    @current_user = current_user

    mail(to: email, cc: current_user.email, subject: subject, body: body)
  end

end
