class User < ActiveRecord::Base
  has_secure_password
  has_many :ideas

  validates :username, presence: true, length: { minimum: 6 }

  enum role: %w(default admin)
end
