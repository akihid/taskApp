class UsersController < ApplicationController

before_action :set_user , only:[:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = '会員登録しました'
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name , :mail , :password , :password_confirmation)
  end
end
