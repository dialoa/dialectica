class SubmissionMailer < ApplicationMailer
  default from: 'dialectica@philosophie.ch'

  def send_to_external_referee(email, subject, body, current_user)

    @email = email
    @subject = subject
    @body = body
    @current_user = current_user

    mail(to: email, cc: current_user.email, bcc: "dialectica@philosophie.ch, sandro.raess@philosophie.ch", subject: subject)
  end

  def send_rejection_to_author(email: nil, subject: nil, body: nil)
    @email = email
    @subject = subject
    @body = body

    mail(to: email, bcc: "dialectica@philosophie.ch, sandro.raess@philosophie.ch", subject: subject)
  end

  def withdraw_submission_email(submission: submission, user: user)

      @subject = "submission withdrawn: #{submission.title}"
      @body = Submission.withdraw_submission_email_text(submission: submission, user: user)
      #@current_user = current_user

      mail(to: submission.email, bcc: "dialectica@philosophie.ch, sandro.raess@philosophie.ch", subject: @subject)
    end

  def one_month_passed_without_case(email: email, submission: submission)

     "one month passed without case: #{submission.title}"

    @email = email
    @subject = "one month passed without case: #{submission.title}"
    @body = Submission.one_month_passed_without_case_text(submission: submission, user: User.where(email: submission.email).first)
    #@current_user = current_user

    mail(to: email, bcc: "dialectica@philosophie.ch, sandro.raess@philosophie.ch", subject: @subject)
  end

  def notify_user_that_submission_expires_soon(submission: submission, user: user)

   @email = user.email
   @subject = "#{submission.title} is about to expire"
   @body = Submission.notify_user_that_submission_expires_soon_text(submission: submission, user: user)
   #@current_user = current_user

   mail(to: @email, bcc: "sandro.raess@philosophie.ch", subject: @subject)
  end

  def ask_author_a_question(user: user, submission: submission, question_answer: question_answer)
    @user = user
    @submission = submission
    @question_answer = question_answer
    @subject = "dialectica: you have been asked a question about your submision"
    @body = Submission.ask_author_a_question_text(user: user, submission: submission, question_answer: question_answer)
    #@current_user = current_user

    mail(to: @submission.email, bcc: "dialectica@philosophie.ch, sandro.raess@philosophie.ch", subject: @subject)
  end

  def send_confirmation_for_submission(email, subject, body, submission, user, password = nil)
    @email = email
    @subject = subject
    @body = body
    @submission = submission
    @password = password || ""
    #dialectica@philosophie.ch

    if password
      @html_string = Submission.new_submission_with_login_text(submission: submission, user: user, password: password)
    else
      @html_string = Submission.new_submission_text(submission: submission, user: user)
    end

    mail(to: email, bcc: "dialectica@philosophie.ch, sandro.raess@philosophie.ch", subject: "Dialectica Submission: #{submission.title}")
  end

  def send_credentials(email, username, password)
    @email = email
    @username = username
    @password = password
    #dialectica@philosophie.ch
    mail(to: email, bcc: "dialectica@philosophie.ch, sandro.raess@philosophie.ch", subject: "credentials for dialectica")
  end

  def send_notifications_of_what_happened_today(user, subject, body)
    mail(to: user.email, bcc: "dialectica@philosophie.ch, sandro.raess@philosophie.ch", subject: subject, body: body)
  end

  def send_notification_of_suggestion(user, subject, body)
    mail(to: user.email, bcc: "sandro.raess@philosophie.ch", subject: subject, body: body)
  end

end
