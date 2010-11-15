require 'spec_helper'

describe BoxcarAPI::User do
  
  before :each do
    @config = YAML.load_file(File.join(File.dirname(__FILE__), 'settings.yml'))
  end

  describe "#notify" do
    it "should sending the notification" do
      box = BoxcarAPI::User.new(@config['email'], @config['password'])
      box.notify("message").code.should == 200
    end
    it "should return error when invalid parameters" do
      box = BoxcarAPI::User.new('myuser', 'mypassWord')
      box.notify("other message").code.should == 401
    end
  end

end
