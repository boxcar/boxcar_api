require 'spec_helper'

describe BoxcarAPI::Provider do

  before :each do
    @config = YAML.load_file(File.join(File.dirname(__FILE__), 'settings.yml'))
    @box = BoxcarAPI::Provider.new(@config['provider_key'], @config['provider_secret'])
  end

  describe "#subscribe" do
    it "should sending an invitation to subscribe" do
      box = BoxcarAPI::Provider.new(@config['provider_key'], @config['provider_secret'])
      box.subscribe(@config['email']).code.should == 200
    end
    it "should return error when invalid parameters" do
      box = BoxcarAPI::Provider.new("invalidkey", "invalidsecret")
      box.subscribe("invalid@email.com").code.should == 401
    end
  end

  describe "#broadcast" do
    it "should broadcasting notifications to all services" do
      @box.broadcast("This is an example message.", "from").code.should == 200
    end
    it "should accept from_screen_name" do
      @box.broadcast("message with screen name", "jtadeulopes").code.should == 200
    end
    it "should accept from_remote_service_id" do
      @box.broadcast("message with service id", "jtadeulopes", "unique").code.should == 200
    end
    it "should accept redirect_payload" do
      @box.broadcast("message with redirect payload", "jtadeulopes", nil, "jdg").code.should == 200
    end
    it "should accept source_url" do
      @box.broadcast("message with url", "jtadeulopes", nil, "jdg", "http://google.com").code.should == 200
    end
    it "should accept icon_url" do
      @box.broadcast("message with icon", "jtadeulopes", nil, "jdg", "http://google.com", "http://graph.facebook.com/jtadeulopes/picture").code.should == 200
    end
  end

  describe "#notify" do
    it "should creating individual notifications" do
      @box.notify(@config['email'], "This is an example message.", "from").code.should == 200
    end
    it "should accept from_screen_name" do
      @box.notify(@config['email'], "message with screen name", "jtadeulopes").code.should == 200
    end
    it "should accept from_remote_service_id" do
      @box.notify(@config['email'], "bla bla", "jtadeulopes", "12345").code.should == 200
    end
    it "should accept redirect_payload" do
      @box.notify(@config['email'], "message with redirect payload", "jtadeulopes", nil, "jdg").code.should == 200
    end
    it "should accept source_url" do
      @box.notify(@config['email'], "message with url", "jtadeulopes", nil, "jdg", "http://google.com").code.should == 200
    end
    it "should accept icon_url" do
      @box.notify(@config['email'], "message with icon", "jtadeulopes", nil, "jdg", "http://google.com", "http://graph.facebook.com/jtadeulopes/picture").code.should == 200
    end
  end

end
