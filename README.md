# FlashS3Rails

Upload files to s3 with flash, including progress bars, in your Rails app.  Configuration requires an s3 key and secret only.

## Installation

Add this line to your application's Gemfile:

    gem 'flash_s3_rails', :require => 'flash_s3'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flash_s3_rails

## Usage

### In `application.rb` or `<environment>.rb` or an initializer

``` ruby
config.flash_s3.bucket = 'mybucketname'
config.flash_s3.s3_access_key_id = "myaccesskey"
config.flash_s3.s3_secret_access_key = "mysecretaccesskey"
```

### In the Model

``` ruby
has_attached_s3_file :media
```

Substitute `media` for your upload name.

### In the View

#### Erb

``` erb
<%= flash_s3_uploader @model\_instance, :media, post\_upload\_callback\_url  %>
```

#### Haml

``` haml
= flash_s3_uploader @model\_instance, :media, post\_upload\_callback\_url
```

Note: You must use the url and not the path for your post callback hook.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
