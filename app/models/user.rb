class User < ActiveRecord::Base

  devise :omniauthable,
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable,
    :omniauth_providers => [:google_oauth2,:github]

  validate :whitelist_admin_email, unless: :developer?
  validates :email, uniqueness: true, presence: true

  belongs_to :developer

  def self.admin_whitelist
    (Rails.application.secrets.admin_whitelist || "").split(";")
  end

  def whitelist_admin_email
    unless User.admin_whitelist.include?(email)
      errors.add(:email, "This email address does not have valid permissions")
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
      name = data["extra"]["raw_info"]["login"]
      user = User.create(name: name,
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
    return nil if developer.nil?
    return developer.user if developer.present? && developer.user.present?
    user = developer.create_user(name: developer.full_name,
      email: developer.email,
      image: data["image"],
      password: Devise.friendly_token[0,20]
    )
    user
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
