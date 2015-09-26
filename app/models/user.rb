class User < ActiveRecord::Base
  include BCrypt
  has_many :surveys
  validates :username, presence: true, uniqueness:true
  validates :password_hash, presence: true
  # users.password_hash in the database is a :string

    def password
      @password ||= Password.new(password_hash)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end
end
