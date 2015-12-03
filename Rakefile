# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.


require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc "email end of week status updates"
task :send_developer_status_updates => :environment do
  if Date.today.wday == 1
    developers = Developer.all
    developers.each do |developer|
      @notification = Notification.create!(
        user: developer.user,
        email: developer.email,
        subject_type: "User",
        email_from: "c4qDevPortal@test.com",
        email_subject: "Status Update",
        kind: "status_update"
      )
      @notification.deliver 
    end
  end
end


desc "parse donations"
task :convert_donor_info_to_csv => :environment do
  File.open("donors.csv", 'w') do |f|
    f.puts("Timestamp, Name, Phone, Amount, Message")
    SmsDonor.includes(:pledges).each do | donor |
      donor.pledges.each do |pledge|
      f.puts("#{pledge.created_at},#{donor.name},#{donor.phone_number},#{pledge.amount},#{pledge.message}.gsub(","," ")")
      end
    end
  end
end

desc "follow up thanks you texts"
task :send_pledge_follow_up => :environment do
  
  twilio_number = "+13475274222"
  recipient_number = "+18652017604"
  sms_message = "Thanks again for your pledge to C4Q. Please reply with your email to receive instructions on how to fulfill your pledge and help us build a more inclusive tech community in NYC."

  client = Twilio::REST::Client.new(Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token)
  
  message = client.account.messages.create(
    :from => twilio_number,
    :to => recipient_number,
    :body => sms_message
  )
  puts message.to
  
end

desc "import android devs and mock interview feedback"
task :import_android_and_interview => :environment do
  cohort = Cohort.create!(version: "2.1", name: "Access Code")
  cohort.import("AndroidDevs.csv", true)
  EvaluationImporter.import_mock_interview("feedbacknew.csv")
end
