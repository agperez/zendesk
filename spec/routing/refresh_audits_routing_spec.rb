require "rails_helper"

RSpec.describe RefreshAuditsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/refresh_audits").to route_to("refresh_audits#index")
    end

    it "routes to #new" do
      expect(:get => "/refresh_audits/new").to route_to("refresh_audits#new")
    end

    it "routes to #show" do
      expect(:get => "/refresh_audits/1").to route_to("refresh_audits#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/refresh_audits/1/edit").to route_to("refresh_audits#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/refresh_audits").to route_to("refresh_audits#create")
    end

    it "routes to #update" do
      expect(:put => "/refresh_audits/1").to route_to("refresh_audits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/refresh_audits/1").to route_to("refresh_audits#destroy", :id => "1")
    end

  end
end
