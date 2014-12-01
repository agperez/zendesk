class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def client
    MyClient.instance
  end
end

class MyClient < ZendeskAPI::Client
  def self.instance
    @instance ||= new do |config|
      config.url = ENV["zendesk_url"]
      config.username = ENV["zendesk_username"]
      config.token = ENV["zendesk_token"]
      config.password = ENV["zendesk_password"]


      config.retry = true

      config.logger = Rails.logger
    end
  end
end
