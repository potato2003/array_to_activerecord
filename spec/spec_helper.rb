require "bundler/setup"
require "array_to_activerecord"
require 'sqlite3'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

    ActiveRecord::Base.connection.create_table :customers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.timestamp :registered_at, null: false
    end
  end

  config.after(:each) do
    ActiveRecord::Base.connection.close
  end
end
