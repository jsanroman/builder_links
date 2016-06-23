# BuilderLinks 

[![Gem Version](https://badge.fury.io/rb/builder_links.svg)](https://badge.fury.io/rb/builder_links)
[![Build Status](https://travis-ci.org/jsanroman/builder_links.svg)](https://travis-ci.org/jsanroman/builder_links) 
[![Test Coverage](https://codeclimate.com/github/jsanroman/builder_links/badges/coverage.svg)](https://codeclimate.com/github/jsanroman/builder_links/coverage)
[![Code Climate](https://codeclimate.com/github/jsanroman/builder_links/badges/gpa.svg)](https://codeclimate.com/github/jsanroman/builder_links)


A ruby gem to generate links automatically based on a text, keywords and urls is given. Useful for example to increase dinamically the internal links in your site and improve SEO metrics.


## Installation

Add this line to your Gemfile's application:

```ruby
gem 'builder_links'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install builder_links

## Configuration
Use an initializer builder_links.rb

```ruby
# all parameters based on which allow to find keywords and build the links
# builder_links will use anchortext to find text and uri to generate the link
BuilderLinks.setup do |config|
  config.patterns = [
    {anchortext: 'google',  uri: 'http://www.google.com'},
    {anchortext: 'builder links',  uri: 'https://github.com/jsanroman/builder_links'},
    {anchortext: "I wanted to illuminate the whole earth", uri: 'https://es.wikipedia.org/wiki/Nikola_Tesla'},
  ]

  # maximum links generated to each call
  config.total_links = 5
  # maximum links generated to each pattern given
  config.links_per_pattern = 1
end
```

## Usage
Call directly to `BuilderLinks.text("", {black_uris: ['google.com']})`

We can add multiple uri's for the `black_uris` option to not generate these links
```ruby
BuilderLinks.text("<p>I wanted to illuminate the whole earth. There is enough electricity to become a second sun.</p>")
```
```ruby
#<p><a href="https://es.wikipedia.org/wiki/Nikola_Tesla">I wanted to illuminate the whole earth</a>. There is enough electricity to become a second sun.</p>
```

Or you can add `builder_links` to your activerecord model, that will generate a method `builder_links(:field)`
```ruby
class Card < ActiveRecord::Base
  attr_accessible :text, :user_text

  builder_links
end

# Then you can use builder_links method
Card.find(1).builder_links(:text, {black_uris: ['google.com']})
Card.find(1).builder_links(:user_text)
```

## Contributing

1. Fork it ( https://github.com/jsanroman/builder_links/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
