Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, (ENV["GOOGLE_CLIENT_ID"] || Rails.application.secrets.google_client_id), (ENV["GOOGLE_CLIENT_SECRET"] || Rails.application.secrets.google_client_secret), {
    :scope => "email, profile, plus.me",
    :image_size => {width: 200, height: 200},
  }

  provider :github, (ENV['GITHUB_CLIENT_ID'] || Rails.application.secrets.github_client_id), (ENV['GITHUB_CLIENT_SECRET'] || Rails.application.secrets.github_client_secret), scope: "user,repo"
end
