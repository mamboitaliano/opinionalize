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

  def self.from_omniauth(auth)
    puts "//////////////////////////////////////////////"
    p auth
    puts
    puts auth.info.email
    puts "//////////////////////////////////////////////"
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.username = auth.info.email
      user.password = SecureRandom.base64
      user.oauth_token = auth.credentials.oauth_token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
