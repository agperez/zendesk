require 'rails_helper'

RSpec.describe "refresh_audits/new", :type => :view do
  before(:each) do
    assign(:refresh_audit, RefreshAudit.new(
      :period => "MyString"
    ))
  end

  it "renders new refresh_audit form" do
    render

    assert_select "form[action=?][method=?]", refresh_audits_path, "post" do

      assert_select "input#refresh_audit_period[name=?]", "refresh_audit[period]"
    end
  end
end
