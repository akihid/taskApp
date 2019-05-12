class GroupMember < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :user, uniqueness: {scope: :group, message: 'は既に参加済です'}

  scope :find_group_member, ->(user_id, group_id) do
    where('user_id = ? and group_id = ?', user_id, group_id)
  end
end
