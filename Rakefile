ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'



# Type `rake -T` on your command line to see the available rake tasks.

desc "start console"
task :console do
  Pry.start
end