# Brownfield Of Dreams

This is the base repo for a brownfield project used at Turing for Backend Mod 3.

This was a brownfield project which means that it was a project that with a partner we needed to add additional features into an exisiting codebase. 

### Project Board

Github project board was used to manage the user stories and other tasks that were needed to complete this project. 

### About the Project

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

## Local Setup

This app uses a few API's to run correctly, you can find the list of needed API keys below which will need to be savedmin an application.yml file within the config directory. 
```
/config/application.yml
# used to pull in videos from Youtube
YOUTUBE_API_KEY:<key>
#  Two github tokens used for testing with RSpec
GITHUB_TOKEN: <key>
TEST_TOKEN: <key> 
# Github project OAuth key and Secret for connecting with Omni-Auth
GITHUB_KEY: <key>
GITHUB_SECRET: <key>
# A Sendgrid API as this is used for sending production emails.
SENDGRID_USERNAME: apikey
SENDGRID_PASSWORD: <key>
```

Clone down the repo
```
$ git clone
```

Install the gem packages
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Run the test suite:
```ruby
$ bundle exec rspec
```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0
