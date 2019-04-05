class Task < ApplicationRecord
  validates :title , presence: true , length: {maximum:20}
  validates :content , presence: true , length: {maximum:200}
  enum status: { 未着手:0, 着手:1, 完了:2}
  validates :status, inclusion:{ in: Task.statuses.keys}

  scope :search_task, ->(title , status) do

    return if (title.nil?  && status.nill?)

    if title.present? && status.present?
      where("title like ? AND status = ?", "%#{title}%" ,  status)
    elsif title.present?
      where("title like ?", "%#{title}%")
    elsif status.present?
      where("status = ?", status)
    end

  end

end
