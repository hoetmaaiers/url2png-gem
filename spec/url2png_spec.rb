require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Url2png" do
  describe "attributes" do
    it "should set mandatory attributes" do
      my_api_key = "my_api_key"
      my_private_key = "my_private_key"
      Url2png.config ({api_key: my_api_key, private_key: my_private_key})
      Url2png.api_key.should eq my_api_key
      Url2png.private_key.should eq my_private_key
    end
    
    it "should throw an exception getting nil api_key" do
      Url2png.config({private_key: "private_key"})
      expect {Url2png.api_key}.to raise_error
    end
    
    it "should throw an exception getting nil private_key" do
      Url2png.config({api_key: "private_key"})
      expect {Url2png.private_key}.to raise_error    end
    
    it "should set mode" do
      mode = "placehold"
      Url2png.config ({mode: mode})
      Url2png.mode.should eq mode
    end
    
    it "should throw an exception with an invalid mode" do
      expect {Url2png.config({mode: "invalid mode"})}.to raise_error
    end
  end
end