## Introduction

This is a Ruby on Rails API that utilizes the following gems:

    - mysql2 for the database
    - puma as the web server
    - rack-cors for handling Cross-Origin Resource Sharing (CORS)
    - grape for the API facade
    - grape-entity for data transfer transformer
    - grape-swagger for API documentation
    - grape-swagger-rails for the UI of the documentation
    - devise for user authentication
    - jwt for JSON Web Tokens
    - active_model_serializers for serializing model data
    - faker for generating fake data
    - rspec-rails for testing
    - spring for speeding up commands on slow machines or big apps
    - sprockets-rails for compiling and serving web assets
    - better_errors for better error handling in development
    - byebug for debugging in development
    - database_cleaner for cleaning the database during testing
    - rails_best_practices for checking for best practices in development
    - rubocop for linting in development
    - rubocop-faker for linting faker usage in development
    - rubocop-rails for linting Rails specific code in development
    - simplecov for code coverage in development
    - listen for file change detection in development
    - factory_bot for factory pattern in testing
    - factory_bot_rails for factory pattern in Rails testing
    - i18n for internationalization
    - minitest for testing
    - minitest-around for testing
    - webmock for stubbing and setting expectations on HTTP requests in Ruby

## Running the API

The API is run as a Docker Image.
To start the API, make sure you have Docker installed and run the following command in the dream-big directory:

Install the Docker extension on vscode

`docker-compose up`

This will start the API on http://localhost:3000.

## Accessing the Docker Console

In order to run rails console commands, you must access the API Docker image. The easiest way to do this is to install the Docker vsc extension.

Once it is installed, you can open the extension by clicking on the whale icon in your Visual Studio Code. Then right-click on the 'api' image and select 'attach shell.'

This will open a new terminal where you can run commands specific to the Rails application. 
You must use this new terminal, as opposed to your regular terminal, to run any of the commands that are related to the Rails application, as they need to be executed within the context of the Docker image.

## Running Tests

TESTS MUST RUN AND PASS BEFORE PUSHING CODE!

To run all the tests in the spec directory:

`rspec`

To run the database model tests:

`rails test test/models`

## API Documentation

The API documentation can be accessed by going to http://localhost:3000/api/docs when the API is running. This will show all the available endpoints and their parameters.

## Code Coverage

Code coverage can be viewed by running the tests with the following command:

`COVERAGE=true rspec`

This will generate a coverage report in the coverage directory.

## Linting

To lint the code, use the following command:

`rubocop`

This will check the code for any style violations and display them in the terminal.

## Best Practices

To check for best practices, use the following command:

`rails_best_practices`

This will check the code for any best practices violations and display them in the terminal