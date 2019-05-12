class Group < ApplicationRecord
  belongs_to :user
  has_many :group_members, dependent: :destroy
  has_many :assign_members , through: :group_members , source: :user


  def assign_member(user)
    group_members.create(user: user)
  end
end
