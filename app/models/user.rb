class User < ActiveRecord::Base

  WHITELIST = [
    "rachel@c4q.nyc",
    "mike@c4q.nyc"
  ]

  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:google_oauth2]

  validate :whitelisted_email

  def whitelisted_email
    unless WHITELIST.include? email
      errors.add(:email, "This email address does not have valid permissions")
    end
  end

  def self.from_omniauth(access_token)
      data = access_token.info
      user = User.where(:email => data["email"]).first

      # Uncomment the section below if you want users to be created if they don't exist
      unless user
          user = User.create(name: data["name"],
             email: data["email"],
             image: data["image"],
             password: Devise.friendly_token[0,20]
          )
      end
      user
  end

end
