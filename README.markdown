# url2png gem

## What is it?
A Ruby gem wrapping the url2png.com API.

## Who should use it?
Any Ruby on Rails developer who wants/needs to generate screenshots from sites using url2png.com.

## Usage

### Installation

    gem install url2png


### Configuration

First define your public key and shared secret:

    Url2png::Config.public_key = 'PXXXXXXXXXXXXX'
    Url2png::Config.shared_secret = 'SXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

In Rails you probably want to do that in your application.rb file.


### Helpers

Generate an image tag:

    site_image_tag url, [options]

Options are the same as the image_tag in Rails.

By default the size is set to 400 x 400 px.
To generate an image with a specific size:

    site_image_tag url, :size => '300x200'

To only get the image url:

    site_image_url url, :size => '300x200'


## Important

This gem is written for Rails 3.
Rails 2 might work but it's not tested.

Note that this gem is still under development.


## Contributing to url2png
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Wout Fierens. See LICENSE.txt for
further details.












