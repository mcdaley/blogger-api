# Blogger API
This is an example program on how to build a simple Rails API server, so that
I can prepare for full stack interviews.

## To Do
### How do I handle bad routes?
When a user makes an API request for a route that is not defined in the
routes.rb, what is the correct way for handling the error. On a web page, the
user is redirected to the 404 page. I assume the API needs to return a 404 
message.

# Getting Started
Before starting, I upgraded my ruby to version 2.6.4 and installed rails 6.0.0.
Next, I created a rails api app that does not include tests by entering the following command:

```
cd project_dir
rails new blogger-api --api -T --skip-coffee
```

# Gem Files
The project includes the following sets of Gems that I've added to the core
rails projects.

## Database

### SQLite
For the API example, I use the default SQLite3 because it is really easy to
get started and is perfect for a simple example program.

## RSpec
RSpec is a 'Domain Specific Language' (DSL) testing tool written in Ruby to test Ruby code.

### Rspec-Rails
The [rspec-rails](https://github.com/rspec/rspec-rails) gem installs all of the rspec gems required to setup rspec for the api project, which include:
  * rspec-rails (3.9.0)
  * rspec-core (3.9.0)
  * rspec-expectations (3.9.0)
  * rspec-mocks (3.9.0)
  * rspec-support (3.9.0)

### FactoryBot
FactoryBot is a fixtures replacement with a straightforward definition syntax, support for multiple build strategies (saved instances, unsaved instances, attribute hashes, and stubbed objects), and support for multiple factories for the same class (user, admin_user, and so on), including factory inheritance

The [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails) gem 
provides the rails integration for [factory_bot](https://github.com/thoughtbot/factory_bot)

## API

### Active Model Serializers
The [Active Model Serializers](https://github.com/rails-api/active_model_serializers) gem enables the conversion of ruby objects to a JSON
response that is returned by the controller/API. 

# Application Structure
The application structure is pretty basic and includes the following 
components. As the example is so simple, I have added a User model, but I 
have not added any authentication.

## Models
* User
* Blog
* Comment - not implented yet

## Controllers
* Api::V1::BlogsController

## Routes
Right now the API only has the following routes:

```
namespace :api do
  namespace :v1 do
    resources :blogs,   except: [:new, :update]
  end
end
```

# Testing w/ RSpec
Using RSpec with FactoryBot to write the tests for the API. Only using Model
and Feature rspecs for testing. The Feature rspecs will test the controllers
and routes.

## FactoryBot
Use the FactoryBot to create the data for the test RSpecs.

## Model Tests
Model tests are used to:
* Test validations
* Test scopes
* Model business logic

## Request Tests
The request tests are used to:
* Test the routes
* Test the output of the controllers

# Debugging and Testing w/ Postman
Postman is a free application that I am using to debug and test the APIs.
Basically, it provides a UI for Curl so that I can send API requests to the
development server on localhost:3000.