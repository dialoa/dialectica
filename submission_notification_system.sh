#!/bin/bash
echo "submission_notification_system" >> cronjob-log.txt
date >> cronjob-log.txt
bin/rails runner "SubmissionNotificationSystem.new.get_submissions_that_have_passed_one_month_without_case"
bin/rails runner "SubmissionNotificationSystem.new.notify_reviewers_when_submissions_are_about_to_be_expired"
