class GroupMembersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @group.group_members.create(user_id: current_user.id)
    redirect_back(fallback_location: request.url)
    flash[:success] = "#{@group.name}に参加しました。"
  end

  def destroy
    @group = Group.find(params[:id])
    group_member = @group.group_members.find_by(user_id: params[:user_id])
    
    if @group.owner?(group_member.user)
      redirect_back(fallback_location: request.url)
      flash[:danger] = "グループのオーナーは除外できません"
    else
      group_member.destroy
      redirect_back(fallback_location: request.url)
      flash[:success] = "#{group_member.user.name}を除外しました。"
    end
  end

  def index
    @group_members = current_user.assign_group
  end

end
