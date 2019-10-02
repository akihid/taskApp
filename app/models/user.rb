class User < ApplicationRecord
  validates :name , presence: true , length: {maximum:20}
  validates :mail , presence: true , format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  before_validation{:mail.downcase}
  has_secure_password
  validates :password , presence: true , length: {minimum:6}
  has_many :tasks , dependent: :destroy
  enum role: { 管理者:true, 一般:false}
  has_many :groups
  has_many :group_members, dependent: :destroy
  has_many :assign_groups , through: :group_members , source: :group
  has_many :read_tasks ,dependent: :destroy
  has_one_attached :icon

  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  def self.current_user
    Thread.current[:current_user]
  end

  def user_is_yourself?(user)
    return false if user.nil?
    self.id == user.id
  end
end
