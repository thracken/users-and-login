class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save {self.email.downcase!}
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: {minimum: 3, maximum: 60}
  validates :email, presence: true, length: {maximum: 255}, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 10, maximum: 255}, allow_nil: true
  has_secure_password

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
