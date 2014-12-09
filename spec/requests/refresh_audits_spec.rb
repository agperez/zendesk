require 'rails_helper'

RSpec.describe "RefreshAudits", :type => :request do
  describe "GET /refresh_audits" do
    it "works! (now write some real specs)" do
      get refresh_audits_path
      expect(response).to have_http_status(200)
    end
  end
end
