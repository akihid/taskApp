class User < ApplicationRecord
  validates :name , presence: true , length: {maximum:20}
  validates :mail , presence: true , format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation{:mail.downcase!}
  has_secure_password
  validates :password , presence: true , length: {minimum:6}
end
