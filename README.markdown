# url2png gem

## What is it?
A Ruby gem wrapping the url2png.com API.

## Who should use it?
Any Ruby on Rails developer who wants/needs to generate screenshots from sites using url2png.com.

## Usage

### Installation

    gem install url2png

### Upgrading

This gem now only supports version 4 of the API. (See https://url2png.com/doc/) If you are upgrading from a previous version, please carefully review the parameters available. You will need to update your usage accordingly.

### Configuration

First define your public key and shared secret:

    Url2png::Config.public_key = 'PXXXXXXXXXXXXX'
    Url2png::Config.shared_secret = 'SXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

In Rails, you probably want to do that in an initializer.


### Helpers

#### site\_image\_url
Get a thumbnail URL from URL2PNG:

    site_image_url(url, :thumbnail => '200x150', :browser_size => '800x600')
 
The options hash can have the following keys provided. (The API's default, min and max values are provided here as a documentation convenience. The gem will not pass any parameters that you leave unspecified.)

##### :thumbnail

This is a proportion bounding box.
Thumbnails will be resized to fit within this box

    example: :thumbnail => '500x500'
             :thumbnail => 'ORIGINAL'
    default: 'ORIGINAL'

##### :browser_size

Set the initial browser screen size.

    example: :browser_size => '1024x2500'
    default: '1024x768
    min: '200x200'
    max: '4000x4000'

##### :delay

Extra delay (in seconds) forced between page load and screenshot.

    example: :delay => 2
    min: 1
    max: 5

##### :fullscreen

When true, Will attempt to capture entire document canvas
Will never return screenshot smaller than "Initial Screen Size"

    example: :fullscreen => true
    default: false

#### site\_image\_tag

Generate an image tag for a thumbnail:

    site_image_tag(url, [options])

The options supported by site\_image\_url will be passed through to it. Any other options provided are set as attributes of the image, except for :size, which is parsed to height and width attributes.

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












