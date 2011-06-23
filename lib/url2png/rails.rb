require File.join(File.dirname(__FILE__), 'helpers', 'common')

ActionView::Base.send(:include, Url2png::Helpers::Common) if defined? ActionView