class Task < ApplicationRecord
  validates :title , presence: true , length: {maximum:20}
  validates :content , presence: true , length: {maximum:200}
  enum status: { 未着手:0, 着手:1, 完了:2}
  validates :status, inclusion:{ in: Task.statuses.keys}
  enum priority: { 高:0, 中:1, 低:2}
  validates :priority, inclusion:{ in: Task.priorities.keys}
  belongs_to :user
  validate :deadline_at_cannot_be_in_the_past, on: :create
  has_many :task_labels, dependent: :destroy
  has_many :task_have_labels, through: :task_labels, source: :label
  has_one_attached :image


  scope :search_task, ->(title , status) do
    return if (title.nil? && status.nil?)
    
    if title.present? && status.present? 
      where("title like ? AND status = ?","%#{title}%" ,  status)
    elsif title.present?
      where("title like ?","%#{title}%")
    elsif status.present?
      where("status = ?",status)
    end
  end

  scope :find_self_task, ->(user_id) do
    where("user_id = ?", user_id)
  end

  scope :search_task_by_limit, ->() do
    where("deadline_at <= ? AND status != ?", Time.zone.today + 1 , 2)
  end

  def deadline_at_cannot_be_in_the_past
    if deadline_at.present? && deadline_at < Date.today
      errors.add(:deadline_at, Task.human_attribute_name('err_msg_deadline_at'))
    end
  end
end
