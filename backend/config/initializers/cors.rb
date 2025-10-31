Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001'

    resource '/api/*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      credentials: true
  end

  # 本番環境設定（必要に応じて追加）
  # allow do
  #   origins 'https://www.your-production-app.com'
  #   resource '/api/*',
  #     headers: :any,
  #     methods: [:get, :post, :put, :patch, :delete, :options, :head],
  #     expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
  #     credentials: true
  # end
end
