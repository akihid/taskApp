class Admin::UsersController < ApplicationController

  before_action :set_user , only:[:edit , :update ,:show ,:destroy]

  def index
    @users = User.all
  end

  def new
    if params[:back]
      @user = User.new(user_params)
    else
      @user = User.new
    end
  end

  def create
    @user =  User.new(user_params)
    if @user.save
      flash[:success] = t('msg.user_create_complete')
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    
    if @user.update(user_params)
      flash[:success] = t('msg.user_update_complete')
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = t('msg.user_destroy_complete')
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name , :mail , :password , :password_confirmation)
  end
end
