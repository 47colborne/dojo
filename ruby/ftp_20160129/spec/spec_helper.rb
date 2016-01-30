require 'rspec'
Dir[File.expand_path('../../lib/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end