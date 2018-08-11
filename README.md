# CNYCN Texting App

This app was built for a [Delta.NYC](https://www.civichalllabs.org/probonotech/) pro bono collaboration with the [Center for NYC Neighborhoods](https://cnycn.org/)

## Setup

Run the following commands:

`gem install bundler`

`bundle`

`bundle exec rake db:migrate`

`cp .env.example .env`

Then add Twilio credentials to the `.env` file

## Run

`ruby app.rb`

## Deployed at

https://texting-app-demo.herokuapp.com/
