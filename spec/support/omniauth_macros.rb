module OmniauthMacros
  def mock_auth_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: :facebook,
      uid: '12345',
      info: {
        name: Faker::Internet.username,
      },
    })
  end
end