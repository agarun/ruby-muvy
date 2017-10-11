require "bundler/setup"
require "muvy"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def suppress_log_output
    allow(STDOUT).to receive(:puts) # Suppress `puts` output
    allow(STDERR).to receive(:write) # Suppress `abort` output
    logger = double('Logger').as_null_object
    allow(Logger).to receive(:new).and_return(logger)
  end
end
