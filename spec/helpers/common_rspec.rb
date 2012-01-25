require 'spec_helper'
require 'url2png/helpers/common'

RSpec.configure do |config|
  config.before :all do
    Url2png::Config.public_key    = public_key
    Url2png::Config.shared_secret = shared_secret
  end
end

describe Url2png do
  include Url2png::Helpers::Common

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


describe Url2png, "site_image_url" do
  context "when no options are provided" do
    subject { SandBox.site_image_url "http://google.com" }

    it { should == "http://api.url2png.com/v4/#{public_key}/#{generate_token}/t400x400/http://google.com" }
    it { should match /\/t400x400\// }
  end

  context "when :thumnail option is provided" do
    subject { SandBox.site_image_url "http://google.com", :thumbnail => '200x300'}

    it { should match /\/t200x300\// }
  end

  describe "legacy support for the :size option " do
    subject { SandBox.site_image_url "http://google.com", :size => '500x300'}

    it { should match /\/t500x300\// }
  end

  [:thumbnail, :size].each do |t|
    context "when #{t} option is false" do
      subject { SandBox.site_image_url "http://google.com", t.to_sym => false}

      it { should_not match /\/t\d+x\d+\// }
    end
  end
end


describe Url2png, "site_image_tag" do
  context "when no options are provided" do
    subject { SandBox.site_image_tag "http://google.com" }

    it { should match /^<img src='http:\/\/api\.url2png\.com/ }
    it { should_not match /height=|width=/ }
  end

  context "when :img_dimensions options are provided" do
    subject { SandBox.site_image_tag "http://google.com", :img_dimensions => {:height => 300, :width => 200} }

    it { should match /height='300'/ }
    it { should match /width='200'/ }
  end

  describe ":size option should no longer dictate <img> height|width dimensions" do
    subject do
      SandBox.site_image_tag "http://google.com", 
        :size => '500x300', :img_dimensions => {:height => 300, :width => 200} 
    end

    it { should_not match /height='500'|width='300'/ }
    it { should match /height='300'|width='200'/ }
  end
end


module SandBox
  extend Url2png::Helpers::Common
end

private

  def public_key
    "P4DBEC0200EE98"
  end

  def shared_secret
    "S169B0E051EAC6794B3EC9F385866187R"
  end

  def generate_token
    safe_url = SandBox.send :uri_escape, "http://google.com"
    SandBox.send :generate_token, shared_secret, safe_url
  end
