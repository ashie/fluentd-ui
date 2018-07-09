require "spec_helper"

describe "out_forward", js: true, stub: :daemon do
  before { login_with exists_user }

  let(:type) { "out_forward" }
  let(:page_url) { send("daemon_setting_#{type}_path") }
  let(:form_values) { {
    Pattern: "*",
    Name: "name",
    Host: "localhost",
    Port: "9999",
  } }

  it "Updated config after submit" do
    daemon.agent.config.should_not include("type file") # out_forward's Secondary hidden field
    form_values.each_pair do |k,v|
      daemon.agent.config.should_not include(v)
    end
    visit page_url
    within("form") do
      form_values.each_pair do |k,v|
        fill_in k, with: v
      end
    end
    click_button I18n.t("fluentd.common.finish")
    form_values.each_pair do |k,v|
      daemon.agent.config.should include(v)
    end
  end

  it "Click to append Server fields", js: true do
    visit page_url
    all(".js-multiple").length.should == 1
    first(".js-multiple .js-append").click
    all(".js-multiple").length.should == 2
  end
end
