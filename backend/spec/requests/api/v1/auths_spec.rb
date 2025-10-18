# spec/requests/api/v1/auths_spec.rb

require 'rails_helper'

RSpec.describe 'Api::V1::Auth', type: :request do
  describe 'POST /api/v1/auth (新規登録)' do
    let(:valid_params) do
      {
        # name: 'Rspec User',
        email: 'rspec@example.com',
        password: 'password',
        password_confirmation: 'password',
        nickname: 'TestNick'
      }
    end

    # 1. 成功テストの修正
    it 'ユーザーが新規作成され、認証ヘッダーが返されること' do
      # JSON文字列をparamsに渡し、Content-Typeヘッダーを付与
      post '/api/v1/auth', params: valid_params.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      # ステータスコード201 (Created)が返ることを確認
      expect(response).to have_http_status(:created)
      
      # データベースにユーザーが作成されたことを確認
      expect(User.last.email).to eq('rspec@example.com')

      # レスポンスヘッダーに認証情報が含まれていることを確認
      expect(response.headers['access-token']).to be_present
    end

    # 2. 失敗テストの修正
    it '無効なパラメータではユーザーが作成されないこと' do
      invalid_params = valid_params.merge(password_confirmation: 'mismatch')
      
      # JSON文字列をparamsに渡し、Content-Typeヘッダーを付与
      post '/api/v1/auth', params: invalid_params.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      # ステータスコード422 (:unprocessable_content) が返ることを確認
      expect(response).to have_http_status(:unprocessable_content) # ★修正点
      
      # ユーザー数が変わっていないことを確認
      expect {
        post '/api/v1/auth', params: invalid_params.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      }.not_to change(User, :count)
    end
  end
end