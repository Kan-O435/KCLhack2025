# spec/rails_helper.rb

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories.
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.chomp
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  # If you're not using ActiveRecord, or you'd prefer not to run each example in a transaction, remove the following line or assign false instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call
  # `get` and `post` directly in specs defined in spec/controllers.
  # The following line is the one that has these automatic mixins:
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  
  # ==========================================================
  # ★★★ DatabaseCleaner の設定はここに追加します ★★★
  # ==========================================================
  
  # テストスイートの開始時にデータベースをトランケーションでクリーンアップ
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # 各テストの前に実行される設定
  config.before(:each) do
    # 通常は高速なトランザクション戦略を使用
    DatabaseCleaner.strategy = :transaction
  end

  # JavaScriptなど、トランザクションが使えないケース（例: feature specs）のための設定
  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  # 各テストの開始時にデータベースをクリーンアップ
  config.before(:each) do
    DatabaseCleaner.start
  end

  # 各テストの終了後にデータベースをクリーンアップ
  config.after(:each) do
    DatabaseCleaner.clean
  end
  
  # ==========================================================
  # ★★★ DatabaseCleaner の設定はここまで ★★★
  # ==========================================================
end