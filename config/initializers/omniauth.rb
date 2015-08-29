Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    :scope => "email, profile, plus.me",
    :image_size => {width: 200, height: 200},
    :client_options => {
        :ssl => {
            :ca_file => "/usr/local/etc/openssl/certs/ca-bundle.crt",
            :ca_path => "/etc/openssl/certs"
        }
    }
  }
end
