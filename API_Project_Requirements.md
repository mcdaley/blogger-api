# Checkr API Example

## Watch GoRails API shows
Find the shows that go over APIs and watch and think about: 
* authentication     - high-level headers and tokens
* json formatting    - responses w/ multiple objects, e.g. blog, author, comments,...
* response structure - header, body, errors, and response codes

## Build example JSON blog message
[
  {
    "id": "123",
    "title": "My Awesome Blog Post",
    "posted": "2019-10-10",
    "author": {
      "id": "1",
      "first_name": "Paul",
      "last_name": "Neuman"
    },
    "comments": [
      {
        "id": "2",
        "message": "Its great"
        "posted": "2019-10-11",
        "commenter": {
          "id": "4",
          "first_name": "Fred",
          "last_name": "Savage",
        },
        ...
      }
    ]
  },
  ...
]

## Build the Base Rails Project
* API controllers
* Rspec for testing
* SQLite DB

## Build Models and DB Tables
Create the models and the DB tables to load the data and:
* Add data validation methods
* Add rspec tests

## Load JSON into DB
User the rake db:seed to load the data into the DB

## Routing
Need to define the routes for all of the APIs

namespace :api do
  namespace :v1 do
    resources :blogs
  end
end

## Implements APIs
Need to think through:
* Error handling
* Response codes!!!
* Response format, e.g., header + body

### Get
Return all of the blog posts w/ title, summary, author, and date posted

### Show
Return single blog post w/ title, sunmary, author, date posted and comments

### Create
Create a new blog post w/ title, summary, and author. 

### Delete
Delete a blog post and its associated comments
