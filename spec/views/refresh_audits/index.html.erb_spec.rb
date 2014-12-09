require 'rails_helper'

RSpec.describe "refresh_audits/index", :type => :view do
  before(:each) do
    assign(:refresh_audits, [
      RefreshAudit.create!(
        :period => "Period"
      ),
      RefreshAudit.create!(
        :period => "Period"
      )
    ])
  end

  it "renders a list of refresh_audits" do
    render
    assert_select "tr>td", :text => "Period".to_s, :count => 2
  end
end
