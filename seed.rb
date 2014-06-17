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

# begin
#   File.read('lib/config/veda_idmatrix.yml')
#   puts "Congratulations you have copied lib/templates/veda_idmatrix.yml to lib/templates/veda_idmatrix.yml"
# rescue
#   puts "You have not copied lib/templates/veda_idmatrix.yml to lib/templates/veda_idmatrix.yml"
#   puts "Please do so and run this file again"
#   exit
# end


puts "This is the result of VedaIdmatrix::Request.access: #{VedaIdmatrix::Request.access}"

# if VedaIdmatrix::Request.access[:access_code].nil?
#   puts "There is no access_code specified in lib/config/veda_idmatrix.yml"
#   puts "Please add your access code and run this file again"
#   exit
# elsif VedaIdmatrix::Request.access[:password].nil?
#   puts "There is no password specified in lib/config/veda_idmatrix.yml"
#   puts "Please add your password and run this file again"
# elsif VedaIdmatrix::Request.access[:url].nil?
#   puts "You have removed the url in lib/config/veda_idmatrix.yml"
#   puts "It should be 'https://ctaau.vedaxml.com/cta/sys2/idmatrix-v4'"
#   exit
# else
#   puts "Your access details are set!"
# end

  