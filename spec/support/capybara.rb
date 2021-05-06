RSpec.configure do |config|
  config.before(:each, type: :system, js: true) do
    driven_by :headless_chrome
  end
end