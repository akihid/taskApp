class Admin::UsersController < ApplicationController

before_action :set_user , only:[:show]

  def index
    @users = User.all
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
