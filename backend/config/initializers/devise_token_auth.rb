# config/initializers/devise_token_auth.rb
DeviseTokenAuth.setup do |config|
  # Use default header rotation so callbacks are correctly defined
  config.change_headers_on_each_request = true
  config.token_lifespan = 2.weeks
  # Exact symbol keys expected by devise_token_auth
  config.headers_names = {
    :'access-token' => 'access-token',
    :client => 'client',
    :expiry => 'expiry',
    :uid => 'uid',
    :'token-type' => 'token-type'
  }
end
