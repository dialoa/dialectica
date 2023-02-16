class SubmissionNotificationSystem
  def initialize()

  end

  def get_submissions_that_have_passed_one_month_without_case
    Submission.where(appearance_date: 30.days.ago.beginning_of_day..30.days.ago.end_of_day).each do |submission|
      if submission.accepted == "false" || submission.proposed == "false"
        SubmissionMailer.one_month_passed_without_case(email: "dialectica@philosophie.ch", submission: submission).deliver_now
      end
    end
  end

  def notify_reviewers_when_submissions_are_about_to_be_expired
    submission_titles = []
    Submission.all.each do |submission|

      if (submission.appearance_date + 31.days - 7.days == Date.today) && (submission.status_for_author == "open")

        submission_titles.push(submission.title)

        submission.users.each do |user|
          SubmissionMailer.notify_user_that_submission_expires_soon(user: user, submission: submission).deliver_now
        end

      end
    end

    return submission_titles
  end

end
