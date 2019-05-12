class User < ApplicationRecord
  validates :name , presence: true , length: {maximum:20}
  validates :mail , presence: true , format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation{:mail.downcase}
  has_secure_password
  validates :password , presence: true , length: {minimum:6}
  has_many :tasks , dependent: :destroy
  enum role: { 管理者:true, 一般:false}
  has_many :groups
  has_many :group_members, dependent: :destroy
  has_many :assign_group , through: :group_members , source: :group
end
