class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include TicketsHelper

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
