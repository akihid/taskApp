class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :contents
      t.date :limit
      t.string :priority
      t.string :status

      t.timestamps
    end
  end
end
