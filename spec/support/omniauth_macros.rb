module OmniauthMacros

  def valid_github_user_auth_hash
    return {
      'provider' => 'github',
      'uid' => '123545',
      'info' => {
        'name' => Developer.first.github_username,
        'image' => 'mock_user_thumbnail_url'
      }
    }
  end

  def invalid_github_user_auth_hash
    return {
      'provider' => 'github',
      'uid' => '123545',
      'info' => {
        'name' => "orta",
        'image' => 'mock_user_thumbnail_url'
      }
    }
  end

  def google_auth_hash
  end

end
