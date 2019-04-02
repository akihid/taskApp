class RenameFromDeadlineToDeadlineAtOnTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :deadline, :deadline_at
  end
end
