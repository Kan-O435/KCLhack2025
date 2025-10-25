# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    # Devise Token Authに必要な最小限のデータ
    sequence(:email) { |n| "test#{n}@example.com" } # 重複しないemailを生成
    password { "password123" }
    password_confirmation { "password123" }
    
    # uidもemailと同じ値で設定 (以前のUserモデルの修正に合わせる)
    uid { email }
    provider { 'email' }
  end
end