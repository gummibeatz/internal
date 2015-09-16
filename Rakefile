# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc "email end of week status updates"
task :send_developer_status_updates => :environment do
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
