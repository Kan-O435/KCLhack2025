# spec/rails_helper.rb

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Active Storageのファイルアップロードに必要なモジュールを読み込み
require 'action_dispatch/testing/test_process' 
require 'fileutils' # FileUtilsの利用を保証

# RSpecがロードされた後、最初に実行される場所で定数を定義
TEST_FILE_PATH = Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg').freeze 

# Checks for pending migrations and applies them before tests are run.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.chomp
end

RSpec.configure do |config|
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  # 組み込みトランザクション機能を無効化 (DatabaseCleanerに任せるため)
  config.use_transactional_fixtures = false 

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  
  # ★★★ Active Storageとファイルアップロードに必要なヘルパー ★★★
  config.include ActionDispatch::TestProcess::FixtureFile
  #config.include ActiveStorage::SetBlob

  # ==========================================================
  # ★★★ DatabaseCleaner の設定 (before/after suiteでファイル操作も実行) ★★★
  # ==========================================================
  
  config.before(:suite) do
    # before(:suite)でTEST_FILE_PATHが定義済みであることを利用し、ファイルを生成
    FileUtils.mkdir_p(File.dirname(TEST_FILE_PATH)) unless Dir.exist?(File.dirname(TEST_FILE_PATH))
    unless File.exist?(TEST_FILE_PATH)
      File.write(TEST_FILE_PATH, 'fake jpeg data', mode: 'wb')
    end
    DatabaseCleaner.clean_with(:truncation)
  end

  config.after(:suite) do
    # テスト完了後にファイルを削除
    File.delete(TEST_FILE_PATH) if File.exist?(TEST_FILE_PATH)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation 
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end