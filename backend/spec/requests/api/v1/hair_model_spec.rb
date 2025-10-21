# spec/requests/api/v1/hair_model_spec.rb

require 'rails_helper'

RSpec.describe 'Api::V1::HairModels', type: :request do
  # 認証済みユーザーを作成 (Devise Token Authのヘルパーを利用)
  let!(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  
  # rails_helper.rbで定義された定数TEST_FILE_PATHを利用
  let(:test_file_path) { TEST_FILE_PATH }

  # before(:context)やafter(:context)のファイル操作ロジックは全て rails_helper.rb に移動したため、ここでは削除

  describe 'POST /api/v1/hair_models (写真・模型データの保存)' do
    
    # fixture_file_uploadはファイルシステムからファイルを読み込む
    let(:valid_params) do
      {
        # test_file_path は letで定義したパスを参照
        photo: fixture_file_upload(test_file_path, 'image/jpeg'),
        model_data: { style: 'short', texture: 'wavy' }.to_json
      }
    end

    # 1. 成功テスト
    context '認証済みユーザーが有効なパラメータでリクエストした場合' do
      it 'HairModelが新規作成され、201が返されること' do
        expect {
          post '/api/v1/hair_models', params: valid_params, headers: auth_headers
        }.to change(HairModel, :count).by(1)
        
        expect(response).to have_http_status(:created)
        
        # データベースに画像が正しく紐づいているか確認
        model = HairModel.last
        expect(model.user).to eq(user)
        expect(model.photo).to be_attached
      end
    end

    # 2. 認証失敗テスト
    context '未認証のユーザーがリクエストした場合' do
      it '401 Unauthorizedが返されること' do
        expect {
          # headers: auth_headers を渡さない
          post '/api/v1/hair_models', params: valid_params
        }.not_to change(HairModel, :count)
        
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end