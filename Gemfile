source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.4"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "redis"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "devise"

group :development, :test do
  gem "byebug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "faker"
  gem "annotate"
  gem "web-console"
  gem "pry-rails"
  gem "binding_of_caller"
  gem "better_errors"
  gem "bullet"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
