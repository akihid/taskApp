class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :label_used_task, through: :task_labels, source: :task


end
