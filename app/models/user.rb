class User < ActiveRecord::Base
  before_save {self.email.downcase!}
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: {minimum: 3, maximum: 60}
  validates :email, presence: true, length: {maximum: 255}, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 10, maximum: 255}
  has_secure_password
end
