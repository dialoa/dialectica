class DailyNotificationMailer < ApplicationMailer
  default from: 'dialectica@philosophie.ch'

  def daily_notification(email, subject)

    @email = email
    @subject = subject
    #@body = body
    #@current_user = current_user

    mail(to: email, bcc: "sandro.raess@philosophie.ch", subject: subject)
  end

end
