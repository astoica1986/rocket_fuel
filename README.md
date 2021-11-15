# README

This README would normally document whatever steps are necessary to get the
application up and running.

# Instalation and Usage
 - setup a ruby/rails environment: ruby-3.0.0 and rails 6.1.4
 - git clone git@github.com:astoica1986/rocket_fuel.git
 - make sure all dependencies for the 'pg' gem are installed
 - bundle install
 - rake db:migrate && db:seed
 - go to localhost:3000 where new instructions can be seen

# Development Notes&Thoughts for Elixirator review team
- The core of the project is the service object called FuelConsumptionService, found in app/services/fuel_consumption_service.rb
- please see spec/services/fuel_consumption_service_spec.rb on how to test the class; I've used the param requirements and examples
that you provided in the task description
- While Ruby is not ideal for using recursion I've tried to somewhat mimic what an Elixir solution would be.
For that reason I've turned on TCO for the ruby vm (application.rb) and used 2 recursive methods
which hopefully work with tail call optimization
- I've also added a very simple (and ugly) UI for testing and demo purposes; this also allows you to add
an unlimited number of possible planets and to change which planet has the capability to fuel a rocket
(maybe Earth will be destroyed by a calamity and humanity will have to move!)
