class SessionsController < ApplicationController
  def new
    # ログインしてるか判定
    if logged_in?
      redirect_to tasks_path
    end
  end

  def create
    @user = User.find_by(mail:params[:session][:mail].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = t('msg.login_complete')
      redirect_to tasks_path
    else
      flash[:danger] = t('msg.login_failed')
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:danger] = t('msg.logout_complete')
    redirect_to new_session_path
  end
end
