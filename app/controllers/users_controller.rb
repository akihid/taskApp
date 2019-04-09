class UsersController < ApplicationController

before_action :set_user , only:[:show]

  def new

    redirect_to tasks_path if logged_in?
    
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = t('msg.user_create_complete')
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def show
    check_another_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name , :mail , :password , :password_confirmation)
  end

  def check_another_user
    unless current_user.id ==  @user.id
      flash[:success] = t('msg.confirm_another_user')
      redirect_to user_path(current_user.id )
    end

  end
end
