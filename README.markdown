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

    Url2png.api_key = 'PXXXXXXXXXXXXX'
    Url2png.privat_key = 'SXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

##### version
You can define the api version if you want to use an older version of the url2png api. 
	
	Url2png.api_version = "v4"

Available versions:

* v6 (default)
* v4


##### mode
If you are generating local urls in development you can use a placeholder or dummy image.
This is done by setting the mode:

    Url2png.mode = :placehold if Rails.env.development?

Options are:

* :production (default; will use the url2png api to generate images)
* :placehold (will generate images at http://placehold.it)
* :dummy (will give a grey base64 data image)

In Rails you probably want to do configuration in an initializer.


### Helpers

Generate an image tag:

    site_image_tag url, [options]


Options differ by version!


### Version 6

##### Thumbnail
Constrain screenshot based on width or height or both.<br>
default: no resizing
		
	= site_image_tag 'http://www.zwartopwit.com', :thumbnail_max_width => 500, :thumbnail_max_height => 500
	

##### Viewport
Set viewport dimensions, adjust to your hearts content.<br>
default: 1480x1037
	
	= site_image_tag 'http://www.zwartopwit.com', :viewport => "1024x900"


##### Fullpage
Will attempt to capture entire document canvas.<br>
default: false
	
	= site_image_tag 'http://www.zwartopwit.com', :fullpage => true
	

##### Delay
Extra delay (in seconds) forced between page load and screenshot.<br>
default: 1<br>
min: 1<br>
max: 5<br>

example:
		
	site_image_tag url, :size => '300x200', :delay => 2
	
	
##### Force
Forces a fresh screenshot with each request, overwriting the previous copy.<br>
**You will be charged for every request made using the force option.**
	
	= site_image_tag 'http://www.zwartopwit.com', :force => true

	
### Version 4

By default the size is set to 400 x 400 px.
To generate an image with a specific size:

    site_image_tag url, :size => '300x200'

To only get the image url:

    site_image_url url, :size => '300x200'

Options are:

##### Size
This is a proportion bounding box.<br>
Thumbnails will be resized to fit within this box.<br>
default: 'ORIGINAL'<br>
examples:

    site_image_tag url, :size => '500x500'

    site_image_tag url, :size => 'ORIGINAL'

##### Thumbnail (alias for :size)

##### Browser size
Set the initial browser screen size.<br>
default: '1024x768'<br>
min: '200x200'<br>
max: '4000x4000'<br>
example:
    
    site_image_tag url, :size => '300x200', :browser_size => '1024x2500'

##### Delay
Extra delay (in seconds) forced between page load and screenshot.<br>
default: 1<br>
min: 1<br>
max: 5<br>
example:

	site_image_tag url, :size => '300x200', :delay => 2

##### Fullscreen
When true, Will attempt to capture entire document canvas.<br>
Will never return screenshot smaller than "Initial Screen Size".<br>
default: false<br>

example:

    site_image_tag url, :size => '300x200', :fullscreen => true



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

Original API docs: 

* v4: https://url2png.com/doc/
* v6: http://staging.url2png.com/docs/v6.php


## Copyright

Copyright (c) 2011 Wout Fierens. See LICENSE.txt for
further details.












