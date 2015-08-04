class User < ActiveRecord::Base

  WHITELIST = [
    "rachel@c4q.nyc",
    "mike@c4q.nyc",
    "max@c4q.nyc",
    "franklin@c4q.nyc"
  ]

  devise :omniauthable,
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable,
    :omniauth_providers => [:google_oauth2]

  validate :whitelisted_email

  def whitelisted_email
    unless WHITELIST.include? email
      errors.add(:email, "This email address does not have valid permissions")
    end
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

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

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  image                  :string
#
