class User < ActiveRecord::Base

  C4Q_WHITELIST = [
    "rachel@c4q.nyc",
    "mike@c4q.nyc",
    "max@c4q.nyc",
    "franklin@c4q.nyc",
    "veena@c4q.nyc",
    "lhl260@nyu.edu",
    "testbot@email.com"
  ]

  DEVELOPER_WHITELIST = Developer.all.map(&:github_username)
  DEVELOPER_WHITELIST.append("testbot")
  
  devise :omniauthable,
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable,
    :omniauth_providers => [:google_oauth2,:github]

  # TODO: figure out how this works with seed data in
  # sandboxed env
  # validate :whitelisted_email
  # validate :whitelisted_github_username
  validates :email, uniqueness: true

  belongs_to :developer

  def whitelisted_email
    return if developer?
    unless C4Q_WHITELIST.include? email
      errors.add(:email, "This email address does not have valid permissions")
    end
  end

  def whitelisted_github_username
    return unless developer?
    unless Developer.all.map(&:github_username).include? developer.github_username
      errors.add(:username, "This github account does not have valid permissions")
    end
  end

  def self.from_omniauth(auth_hash)
    provider = auth_hash["provider"]
    if provider == "github"
      user = self.from_github_omniauth(auth_hash)
    elsif provider == "google_oauth2"
      user = self.from_google_omniauth(auth_hash)
    end
    user
  end

  def self.from_google_omniauth(auth_hash)
    data = auth_hash.info
    user = User.where(email: data["email"]).first

    unless user
      user = User.create(name: data["name"],
         email: data["email"],
         image: data["image"],
         password: Devise.friendly_token[0,20]
      )
    end

    user
  end

  def self.from_github_omniauth(auth_hash)
    data = auth_hash.info
    developer = Developer.where(github_username: data["nickname"]).first
    if developer
      @user = developer.user
    else
      @user = User.create(name: data["name"],
        email: data["email"],
        image: data["image"],
        password: Devise.friendly_token[0,20]
      )
    end
    @user
  end

  def developer?
    developer_id.present?
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
#  developer_id           :integer
#
