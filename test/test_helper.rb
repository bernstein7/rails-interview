ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  setup do
    Rails.application.load_seed
  end

  teardown do
    User.delete_all
    Question.delete_all
    Answer.delete_all
  end
end
