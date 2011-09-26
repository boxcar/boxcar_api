require 'spec_helper'

describe BoxcarAPI::User do
  
  before :each do
    @config = YAML.load_file(File.join(File.dirname(__FILE__), 'settings.yml'))
  end

  describe "#notify" do
    before :each do
      @box = BoxcarAPI::User.new(@config['email'], @config['password'])
    end
    it "should return error when invalid parameters" do
      box = BoxcarAPI::User.new('myuser', 'mypassWord')
      box.notify("other message").code.should == 401
    end
    it "should sending the notification" do
      @box.notify("message").code.should == 200
    end
    it "should accept from_screen_name" do
      @box.notify("my message", "jtadeulopes").code.should == 200
    end
    it "should accept from_remote_service_id" do
      @box.notify("my message with unique", "jtadeulopes", "uniquely_identify").code.should == 200
    end
    it "should not be delivered, because you've already gotten it" do
      @box.notify("message duplicate", "jtadeulopes", "uniquely_identify").code.should == 400
    end
    it "should accept source_url" do
      @box.notify("message with url", "jtadeulopes", nil, "http://facebook.com").code.should == 200
    end
    it "should accept icon_url" do
      @box.notify("message with picture", "jtadeulopes", nil, "http://facebook.com", "http://graph.facebook.com/jtadeulopes/picture").code.should == 200
    end
  end

end
