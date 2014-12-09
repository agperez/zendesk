require 'rails_helper'

RSpec.describe "refresh_audits/show", :type => :view do
  before(:each) do
    @refresh_audit = assign(:refresh_audit, RefreshAudit.create!(
      :period => "Period"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Period/)
  end
end
