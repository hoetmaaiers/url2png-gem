require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/url2png/helpers/common.rb')

describe Url2png do
  include Url2png::Helpers::Common
  
  describe "site_image_tag" do
    it "should return the url of the http://pasparout.com image" do
      site_image_tag('http://pasparout.com').should_not be_nil
    end
  end
end