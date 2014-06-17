# Note for gem developer/contributer
# Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.
# The filename in the lib/config directory is included in the gitignore file
# Do not change the file in the lib/templates directory
#
# run 'bundle console'and then
# load 'seed.rb' to load this seed data

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:',
  )
require_relative 'spec/schema'

puts "#access: #{VedaIdmatrix::Request.access}"