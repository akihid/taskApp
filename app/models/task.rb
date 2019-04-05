class Task < ApplicationRecord
  validates :title , presence: true , length: {maximum:20}
  validates :content , presence: true , length: {maximum:200}

  validate :deadline_at_cannot_be_in_the_past, on: :create
 
  def deadline_at_cannot_be_in_the_past
    if deadline_at.present? && deadline_at < Date.today
      errors.add(:deadline_at, Task.human_attribute_name('err_msg_deadline_at'))
    end
  end
end
