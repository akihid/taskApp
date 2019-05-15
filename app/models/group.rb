class Group < ApplicationRecord
  belongs_to :user
  has_many :group_members, dependent: :destroy
  has_many :assign_members , through: :group_members , source: :user


  def assign_member(user)
    group_members.create(user: user)
  end

  def owner?(user)
    return false if user.nil?
    self.user_id == user.id
  end

  def assign?(user)
    return false if user.nil?
    return false unless self.group_members.present?
    # return self.assign_members.any?{ |assign_member| assign_member.id == user.id }
    return assign_members.exists?(id: user.id)
  end

end
