class CreateReadTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :read_tasks do |t|
      t.integer :task_id
      t.integer :user_id
      t.boolean :read_flg, default: true

      t.timestamps
    end
    add_index :read_tasks, [:task_id, :user_id], unique: true
  end
end
