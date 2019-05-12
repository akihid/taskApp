class GroupMembersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    user = User.find_by(mail:params[:mail])

    if user.present?
      group_member = @group.group_members.new(user_id: user.id)

      if group_member.save
        redirect_back(fallback_location: request.url)
        flash[:success] = "#{group_member.name}さんを#{@group.name}に招待しました。"
      else
        redirect_back(fallback_location: request.url)
        flash[:warning] = group_member.errors.full_messages
      end

    else
      redirect_back(fallback_location: request.url)
      flash[:warning] = "メールアドレス：#{params[:mail]}のユーザーは存在しません"    
    end
  end

  def destroy
    group_member = current_user.group_members.find_by(id:params[:id]).destroy
    redirect_back(fallback_location: request.url)
    flash[:warning] = "#{favorite.post.user.name}さんを#{favorite.post.user.name}から除外しました。"
  end

  def index
    @group_members = current_user.assign_group
  end
end
