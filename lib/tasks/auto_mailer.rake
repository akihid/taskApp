namespace :auto_mailer do
  desc "終了間近のタスク通知"
  task mail_to_near_deadline_at: :environment do
    users = User.all

    users.each do | user |
      @tasks = user.tasks.search_task_by_limit

      TaskMailer.deadline_at(user, @tasks).deliver
    end    
  end
end
