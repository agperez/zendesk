require 'rails_helper'

RSpec.describe "refresh_audits/edit", :type => :view do
  before(:each) do
    @refresh_audit = assign(:refresh_audit, RefreshAudit.create!(
      :period => "MyString"
    ))
  end

  it "renders the edit refresh_audit form" do
    render

    assert_select "form[action=?][method=?]", refresh_audit_path(@refresh_audit), "post" do

      assert_select "input#refresh_audit_period[name=?]", "refresh_audit[period]"
    end
  end
end
