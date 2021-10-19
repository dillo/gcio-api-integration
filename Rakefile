# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# partial success running from command line with
# rake test TEST=test/integration/product_flows_test.rb --trace

require_relative "config/application"
# caused uninitialzied constant ApplicationController error!!
# require_relative "app/controllers/products_controller"

task default: %w[test]

puts "The Rails.env is " + Rails.env

require 'rake/testtask.rb'
    
# BUT this require below gives me a LoadError: cannot load such file
# require 'app/controllers/products_controller.rb'

Rails.application.load_tasks



