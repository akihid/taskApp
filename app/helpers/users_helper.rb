module UsersHelper
  def admin_new_or_edit
    if action_name == "new"  or action_name == "create" 
      admin_users_path
    elsif action_name == "edit" or action_name == "update" 
      admin_user_path
    end
  end
end
