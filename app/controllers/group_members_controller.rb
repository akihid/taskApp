class GroupMembersController < ApplicationController
  def create
    group_member = current_user.group_members.create(group_id:params[:group_id])
    redirect_back(fallback_location: request.url)
    flash[:success] = "#{favorite.post.user.name}さんの投稿をお気に入り登録しました。"
  end

  def destroy
    group_member = current_user.group_members.find_by(id:params[:id]).destroy
    redirect_back(fallback_location: request.url)
    flash[:warning] = "#{favorite.post.user.name}さんの投稿をお気に入り解除しました。"
  end

  def index
    @group_members = current_user.assign_group
  end
end
