#!/bin/bash
bin/rails runner "SubmissionNotificationSystem.new.get_submissions_that_have_passed_one_month_without_case"
echo "submission_notification_system" >> cronjob-log.txt
date >> cronjob-log.txt
