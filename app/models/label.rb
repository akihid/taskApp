class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :label_used_task, through: :task_labels, source: :task

  def used_count
    self.task_labels.count
  end
end

# lhvuifdagivfbuf = Label.find(1)
# lhvuifdagivfbuf.create_chart() lhvuifdagivfbuf == self