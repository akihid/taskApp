class RenameColumnsOnTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :contents, :content
    rename_column :tasks, :limit, :deadline
  end
end
