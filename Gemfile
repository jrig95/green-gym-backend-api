source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.5'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', '~> 1.4'
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# devise
gem 'devise'

# Pundit
gem 'pundit'

# For token used in API calls on behalf of a given user
gem 'simple_token_authentication'

# faker gem for generating seed
gem 'faker'

# jwt gem
gem 'devise-jwt'

# serializer
gem 'fast_jsonapi'

# for aliyun file upload
gem 'activestorage-aliyun'

# recommended for active_storage
gem 'image_processing'

# for saving images/videos
gem 'open-uri'

# to test if action mailer works in development
gem 'letter_opener', group: :development

gem 'activemodel-serializers-xml'
gem 'active_model_serializers'

# for transactional emails in production
gem 'postmark-rails'

# to store the potmark api key
gem 'dotenv-rails', groups: [:development, :test]

# for the SMS sender using Tencent Cloud
gem 'qcloud-sms'   # Ruby Gems 安装源

# To generate the OTP for a user after user is created
# gem 'active_model_otp'

gem 'acts-as-taggable-on'
