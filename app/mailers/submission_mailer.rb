class SubmissionMailer < ApplicationMailer
  default from: 'dialectica@philosophie.ch'

  def send_to_external_referee(email, subject, body, current_user)

    @email = email
    @subject = subject
    @body = body
    @current_user = current_user

    mail(to: email, cc: current_user.email, subject: subject, body: body)
  end

  def send_confirmation_for_submission(email, subject, body, submission, password = "")
    @email = email
    @subject = subject
    @body = body
    @submission = submission
    @password = password || ""
    #dialectica@philosophie.ch
    mail(to: email, bcc: "dialectica@philosophie.ch", subject: "Dialectica Submission: #{submission.title}")
  end

  def send_credentials(email, username, password)
    @email = email
    @username = username
    @password = password
    #dialectica@philosophie.ch
    mail(to: email, bcc: "sandro.raess@philosophie.ch", subject: "credentials for dialectica")
  end

  def send_notifications_of_what_happened_today(user, subject, body)
    mail(to: user.email, subject: subject, body: body)
  end

  def send_notification_of_suggestion(user, subject, body)
    mail(to: user.email, subject: subject, body: body)
  end

end
