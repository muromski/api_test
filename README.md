# README

This API is a system for the work of the labor exchange.
The user can create vacancies, listing the necessary requirements, and respond to them, as well as delete or expose them.

#### How to setup project

- Install ruby 2.7.2 (using rbenv or rvm) - https://github.com/rbenv/rbenv
- Install bundler gem by executing `gem install bundler`

#### How to run project

- Run Postgress `service postgresql start`
- Install gems by executing `bundle install`
- Run migrations `bundle exec rake db:migrate`
- Run Rails `rails s`

### Postman collection

Latest postman collection - https://www.getpostman.com/collections/8a4876ef6f1a814d94c2
