##### by Dillo Raju
# GovCIO API Integration

### Overview

Take home Ruby on Rails project.

* **Ask:**

     * _"Prototype a web application for scheduling an appointment"_

* **Input:**

   *  _"Given a [CSV dataset](./lib/tasks/coaches.csv) that contains the active coaches and their 
     weekly schedule of their available hours, Output the following
     User Stories:"_
         
* **Output:**
        
    * _As a User, I want to see which coaches I can schedule with._
    
    * _As a User, I want to see what 30 minute timeslots are available to schedule with a particular coach._
    
    * _As a User, I want to book an appointment with a coach at one of their available times._
               
* **Anit-Requirements:**

     * _You can't do it all. We respect your time, and expect that you will have to make 
        choices and tradeoffs for what is in scope for your deliverable._
     
     * _Don't worry about authentication. Assume a non-authenticated experience to keep things simple._
     
     * _Pick your stack. Choose any gems that help you produce the highest quality work in the time available._
    

### Local Setup

* `bundle install`
* `bundle exec rails db:setup`

### Run RSpec's

* `bundle exec rspec`


### Run Rubcop

* `bundle exec rubocop`

### Run App Locally

* `bundle exec rails s`
* `http://localhost:3000/`
