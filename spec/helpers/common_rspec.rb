require 'spec_helper'
require 'url2png/helpers/common'

describe Url2png do
  include Url2png::Helpers::Common
  before(:all) do
    Url2png::Config.public_key = "P4DBEC0200EE98"
    Url2png::Config.shared_secret = "S169B0E051EAC6794B3EC9F385866187R"
  end
  
  describe "site_image_tag" do
    it "should return the url of the http://pasparout.com image" do
      site_image_tag('http://pasparout.com').should_not be_nil
    end
  end
  
  describe "site_image_url" do
    it "should encode the thumbnail size when provided" do
      site_image_url('http://www.nytimes.com/', :thumbnail => '200x300').should =~ %r{t200x300}
    end
    
    it "should encode the initial browser size when provided" do
      site_image_url('http://www.nytimes.com/', :browser_size => '200x300').should =~ %r{s200x300}
    end
    
    it "should encode the delay when provided" do
      site_image_url('http://www.nytimes.com/', :delay => 3).should =~ %r{d3}
    end
    
    it "should encode the fullscreen capture flag when provided" do
      site_image_url('http://www.nytimes.com/', :fullscreen => true).should =~ %r{FULL}
    end

    it "should concatenate options by using hyphens" do
      site_image_url('http://www.nytimes.com/', :delay => 3, :fullscreen => true).should =~ %r{d3-FULL}
    end
  end
end