class SubmissionNotificationSystem
  def initialize()

  end

  def get_submissions_that_have_passed_one_month_without_case
    Submission.where(created_at: 30.days.ago.beginning_of_day..30.days.ago.end_of_day).each do |submission|
      if submission.accepted == "false" || submission.proposed == "false"
        SubmissionMailer.one_month_passed_without_case(email: "dialectica@philosophie.ch", submission: submission).deliver_now
      end
    end
  end

end
