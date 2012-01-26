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

If you are generating local urls in development you can use a placeholder or dummy image.
This is done by setting the mode:

    Url2png::Config.mode = :placehold if Rails.env.development?

Options are:

* :production (default; will use the url2png api to generate images)
* :placehold (will generate images at http://placehold.it)
* :dummy (will give a grey base64 data image)

In Rails you probably want to do configuration in an initializer.


### Helpers

Generate an image tag:

    site_image_tag url, [options]

Options are the same as the image_tag in Rails.

By default the size is set to 400 x 400 px.
To generate an image with a specific size:

    site_image_tag url, :size => '300x200'

To only get the image url:

    site_image_url url, :size => '300x200'

Options are:

**:size**<br>
  This is a proportion bounding box.<br>
  Thumbnails will be resized to fit within this box.<br>
  default: 'ORIGINAL'<br>
  examples:

    site_image_tag url, :size => '500x500'

    site_image_tag url, :size => 'ORIGINAL'

  note:  
  `:size` option no longer renders the `<img>` tag height|width. See `:img_dimensions`

  disabling "Thumbnail-ing":  

    site_image_tag url, :size => false
    - or -
    site_image_tag url, :thumbnail => false

    #=> returns the tag without the tOPTION in the url

**:thumbnail** (alias for :size)

**:img_dimensions**  

  Allows you to manually set the `<img>` tag height & width attributes  
  By default, height and width dimensions are omitted

  examples:  

    site_image_tag url, :img_dimensions => {:height => 200, :width => 300}
    #=> <img src='...' height='200' width='300'>

**:browser_size**<br>
  Set the initial browser screen size.<br>
  default: '1024x768'<br>
  min: '200x200'<br>
  max: '4000x4000'<br>
  example:
    
    site_image_tag url, :size => '300x200', :browser_size => '1024x2500'

**:delay**<br>
  Extra delay (in seconds) forced between page load and screenshot.<br>
  default: 1<br>
  min: 1<br>
  max: 5<br>
  example:

    site_image_tag url, :size => '300x200', :delay => 2

**:fullscreen**<br>
  When true, Will attempt to capture entire document canvas.<br>
  Will never return screenshot smaller than "Initial Screen Size".<br>
  default: false<br>
  example:

    site_image_tag url, :size => '300x200', :fullscreen => true


**:cache**  

  When true, the gem will attempt to get the 302 redirection location, which references a "cached" url.  
  This was the preferred method of providing Outlook safe urls, as discussed with the creator of URL2PNG.  
  *This can take some time when executing, in personal tests, it adds about 3-4 secs to the request for a fresh url*

  default: false  
  example:

    site_image_tag url, :cache => true
    #=> <img src="http://cache.url2png.com/..../...." ... />


Original API docs: https://url2png.com/doc/



### API Version
From version 0.1.0 and up this gem is using version 4 of the url2png API.<br>
Version 0.0.7 is the last one using version 3 of the API.


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












