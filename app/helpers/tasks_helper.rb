module TasksHelper
  def chose_new_or_edit
    if action_name == 'new' or action_name == 'confirm'
      confirm_tasks_path
    elsif action_name == 'edit'
      task_path
    end
  end
end
