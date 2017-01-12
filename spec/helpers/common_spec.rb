require 'spec_helper'

describe Url2png do
  include Url2png::Helpers::Common

  before(:all) do
    Url2png.config({
      :api_key => "P4DBEC0200EE98",
      :private_key => "S169B0E051EAC6794B3EC9F385866187R"
    })
  end

  describe "site_image_tag" do
    it "should return the url of the http://pasparout.com image" do
      site_image_tag('http://pasparout.com').should_not be_nil
    end
  end

  describe "site_image_url" do
    it "should allow unique" do
      site_image_url('http://www.nytimes.com/', unique: 'unique').should =~ %r{unique=unique}
    end

    it "should allow unique" do
      site_image_url('http://www.nytimes.com/', accept_languages: 'de').should =~ %r{accept_languages=de}
    end

    it "should allow custom_css_url" do
      site_image_url('http://www.nytimes.com/', custom_css_url: 'http://random.com/random.css').should =~ %r{custom_css_url}
    end

    it "should allow user_agent" do
      site_image_url('http://www.nytimes.com/', user_agent: 'ua').should =~ %r{user_agent=ua}
    end

    it "should allow say_cheese" do
      site_image_url('http://www.nytimes.com/', say_cheese: 'true').should =~ %r{say_cheese=true}
    end

    it "should allow ttl" do
      site_image_url('http://www.nytimes.com/', ttl: 'ttl').should =~ %r{ttl=ttl}
    end

    it "should encode the thumbnail max width when provided" do
      site_image_url('http://www.nytimes.com/', :thumbnail_max_width => '200').should =~ %r{thumbnail_max_width=200}
    end

    it "should encode the thumbnail max height when provided" do
      site_image_url('http://www.nytimes.com/', :thumbnail_max_height => '400').should =~ %r{thumbnail_max_height=400}
    end

    it "should encode the viewport size when provided" do
      site_image_url('http://www.nytimes.com/', :viewport => '200x300').should =~ %r{viewport=200x300}
    end

    it "should encode the delay when provided" do
      site_image_url('http://www.nytimes.com/', :delay => 3).should =~ %r{delay=3}
    end

    it "should encode the fullpage flag when provided" do
      site_image_url('http://www.nytimes.com/', :fullpage => true).should =~ %r{fullpage=true}
    end

    it "should concatenate options by using ampersands" do
      site_image_url('http://www.nytimes.com/', :delay => 3, :fullpage => true).should =~ %r{delay=3&fullpage=true}
    end

    it "should request the png format by default" do
      site_image_url('http://www.nytimes.com/').should =~ %r{png}
    end

    it "should request the json format" do
      site_image_url('http://www.nytimes.com/', :format => :json).should =~ %r{json}
    end

    it "should request the png format" do
      site_image_url('http://www.nytimes.com/', :format => :png).should =~ %r{png}
    end
  end
end
