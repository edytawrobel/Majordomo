# Majordomo ![Travis CI](https://travis-ci.org/sliute/majordomo.svg?branch=master) [![Coverage Status](https://coveralls.io/repos/github/sliute/majordomo/badge.svg?branch=master)](https://coveralls.io/github/sliute/majordomo?branch=master)

The room booking and occupancy web app.

## User Stories

User stories are available [here](/kickoff/majordomo_user_stories.md).

## Technology

* Ruby 2.3.3
* Rails 5.0.1
* postgresql
* Rspec-rails & Capybara
* haml (with haml_rails)
* bootstrap3-datetimepicker-rails (with momentjs-rails)
* simple_calendar
* validates_overlap
* date_validator

## How To Use the App

Go straight to https://majordomo-makers.herokuapp.com.

Or on your own machine, open your terminal and:

```
$ git clone https://github.com/sliute/majordomo.git
$ cd majordomo
$ bundle
$ bin/rake db:create
$ bin/rake db:migrate
$ bin/rails s
```
Then go to http://localhost:3000.

## Progress

1. __MVP technical accomplishments__
  * Back-end:
    - validating for overlapping bookings in the respective model
    - building a self-updating room status view.
  * Front-end:
    - [TO ADD HERE]
2. __Post-MVP technical accomplishments__
  * Back-end:
    - introducing the room model, the one-to-many relationship (one room, many bookings) and the room-booking association
    - this required a complete redo of the booking overlap validation (via a 3rd party gem) and a partial redo of the room status
    - it also required a major refactoring of the booking feature test suite, to accommodate new routes and relationships
  * Front-end:
    - [TO ADD HERE]

## Issues

1. __MVP struggles__
  * Back-end:
    - capturing data from a 3rd party date-time picker and funnelling it into the booking model/db.
  * Front-end:
    - [TO ADD HERE]
2. __Post-MVP struggles__
  * Back-end:
    - introducing the room model after the booking model. This required a significant rewrite of the existing code and test bases.
  * Front-end:
    - [TO ADD HERE]
