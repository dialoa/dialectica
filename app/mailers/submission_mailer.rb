class SubmissionMailer < ApplicationMailer
  default from: 'dialecticaphilosophie@gmail.com'

  def send_to_external_referee(email, subject, body, current_user)

    @email = email
    @subject = subject
    @body = body
    @current_user = current_user

    mail(to: email, cc: current_user.email, subject: subject, body: body)
  end

  def send_confirmation_for_submission(email, subject, body, submission)
    @email = email
    @subject = subject
    @body = body
    @submission = submission
    #dialectica@philosophie.ch
    mail(to: email, bcc: "dialectica@philosophie.ch", subject: "Submission: #{submission.title}")
  end

  def send_notifications_of_what_happened_today(user, subject, body)
    mail(to: user.email, subject: subject, body: body)
  end

  def send_notification_of_suggestion(user, subject, body)
    mail(to: user.email, subject: subject, body: body)
  end

end
