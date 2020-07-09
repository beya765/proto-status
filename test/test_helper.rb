ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all

  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end

  # テストユーザーとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  # L9.24: テストユーザーとしてログインする(統合テスト用)
  # sessionを直接取り扱うことができないので、Sessionsリソースに対してpostを送信することで代用
  def log_in_as(user, password: 'password')
    post login_path, params: { email: user.email, password: password } 
  end
end

