class TaskMailer < ApplicationMailer
  def deadline_at(user, tasks)
    @user = user
    @tasks = tasks
    mail to: user.mail
    mail subject: "終了期限間近のタスクがあります"

    puts "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝"
    puts "メール送信処理の中"
    puts "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝"
  end
end
