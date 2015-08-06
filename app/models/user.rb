class User < ActiveRecord::Base
  has_secure_password

  validates :username, :password, :email, :first_name, :last_name, presence: true
  validates :username, :email, uniqueness: true
end
