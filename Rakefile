# Add the support directory to the load paths
$:.push File.join(File.dirname(__FILE__), 'tasks/support')

# Make sure the directory with the Rake tasks is
# at the front of the load path.
$:.unshift 'tasks'

require 'rubygems'
require 'rake'

# run `rake -T` to list all of the tasks

##
# Allow loading of rake tasks to continue after there
# is an error. Outputs an error message if a task fails
# to load.
def safe_load
  begin 
    yield
  rescue LoadError => ex
    puts 'Error loading rake tasks, but will continue . . .'
    puts ex.message
  end
end

##
# Load all of the rake tasks in the tasks directory of
# the project.  Continue if there are any errors.
Dir.glob('tasks/**/*.rake').each do |rakefile|
  safe_load { load rakefile }
end

##
# Load rake tasks from third-party gems. Again, make
# sure that we are able to continue if there is an 
# error.
safe_load do
  #require 'yard'
end
