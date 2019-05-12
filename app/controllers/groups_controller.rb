class GroupsController < ApplicationController

  before_action :set_group , only:[:edit, :update, :destroy, :show]

  def index
    @groups = Group.all
  end
  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)

    if @group.save
      @group.assign_member(current_user)
      flash[:success] = t('msg.new_group_complete')
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    @group.update(group_params)
    redirect_to groups_path , notice: "グループ「#{@group.name}」を更新しました。"
  end

  def show
  end

  def destroy
    @group.destroy
    redirect_to groups_path , notice: "グループ「#{@group.name}」を削除しました。"
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
