class GroupMember < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :user, uniqueness: {scope: :group, message: 'は既に参加済です'}
end
