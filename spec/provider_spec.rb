require 'spec_helper'

describe BoxcarAPI::Provider do

  before :each do
    @config = YAML.load_file(File.join(File.dirname(__FILE__), 'settings.yml'))
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
      box = BoxcarAPI::Provider.new(@config['provider_key'], @config['provider_secret'])
      box.broadcast("This is an example message.", "from").code.should == 200
    end
  end

  describe "#notify" do
    it "should creating individual notifications" do
      box = BoxcarAPI::Provider.new(@config['provider_key'], @config['provider_secret'])
      box.notify(@config['email'], "This is an example message.", "from").code.should == 200
    end
  end

end
