# FlashS3Rails

Upload files to s3 with flash, including progress bars, in your Rails app.  Configuration requires an s3 key and secret only.

## Installation

Add this line to your application's Gemfile:

    gem 'flash_s3_rails', '~> 0.0.1.beta1', :require => 'flash_s3'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flash_s3_rails --pre

## Usage

### In `application.rb` or `<environment>.rb` or an initializer

``` ruby
config.flash_s3.bucket = 'mybucketname'
config.flash_s3.s3_access_key_id = "myaccesskey"
config.flash_s3.s3_secret_access_key = "mysecretaccesskey"
```

### In a migration

``` ruby
add_column :<your_model_name_pluralized>, :<your_attachment_name>_s3_key :string
```

e.g.

``` ruby
add_column :videos, :media_s3_key, :string
```

### In the Model

Let's say it's called `Video`.

``` ruby
has_attached_s3_file :media
```

Substitute your upload name for `media`.

### In your `app/assets/javascripts/application.js`

``` js
//= require jquery.ui.all
//= require jquery.flashS3
```

### In the View

#### Erb

``` erb
<%= flash_s3_uploader @video, :media, post_upload_callback_url  %>
```

#### Haml

``` haml
= flash_s3_uploader @video, :media, post_upload_callback_url
```

Note: You must use the url and not the path for your post callback hook.

### In your Controller (post upload callback action)

``` ruby
def create
  @video = Video.new(params[:video])
  @video.save!
  head :ok
end
```

Or whatever ;)  The point is to `new`, `create`, `update_attributes`, etc, your Model instance with the `attachment_s3_key` column and `has_attached_s3_file` and save it!  Your s3_key will be saved automagically.

## Upcoming

* Additional _custom_ post callback params
* More configurable, e.g. max file size, file type(s) accepted
* Drop jquery-ui dependency and implement a simple css progress bar
* Make the green box a little less ugly ;)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
