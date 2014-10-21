class OmniauthHelper
  def self.valid_user(opts = {})
    default = { provider: :facebook,
                uid: '1234',
                info: {
                  email: 'foobar@example.com',
                  gender: 'Male',
                  first_name: 'foo',
                  last_name: 'bar'
                }
              }
    configure_omniauth default.merge(opts)
  end

  def self.invalid_user(opts = {})
    configure_omniauth({ provider: :facebook,
                         invalid: :invalid_crendentials
                       }.merge(opts))
  end

  def self.configure_omniauth(data)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[data[:provider]] = data
  end
end
