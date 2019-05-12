class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)

    if @group.save
      flash[:success] = t('msg.new_group_complete')
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
