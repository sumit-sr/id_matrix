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
@entity_hash = {
          :family_name => "Potter",
          :first_given_name => "James",
          :other_given_name => "Harry",
          :date_of_birth => "1980-07-31",
          :gender => "male",
          :current_address => {
            :property => "Potter Manor",
            :unit_number => "3",
            :street_number => "4",
            :street_name => "Privet",
            :street_type => "Drive",
            :suburb => "Little Whinging",
            :state => "NSW",
            :postcode => "2999",
            :unformatted_address => "Potter Manor 3/4 Privet Drive Little Whinging NSW 2999"
          },
          :previous_address => {
            :property => "Veda House",
            :unit_number => "15",
            :street_number => "100",
            :street_name => "Arthur",
            :street_type => "Street",
            :suburb => "North Sydney",
            :state => "NSW",
            :postcode => "2060",
            :unformatted_address => "Veda House 15/100 Arthur Street North Sydney NSW 2060"
          },
          :home_phone_number => "0312345678",
          :mobile_phone_number => "0487654321",
          :work_phone_number => "040012312",
          :phone_authentication_number => "0487654321",
          :send_pin_method => "sms",
          :email_address => "harry.potter@example.com",
          :alternative_email_address => "hpotter@example.com",
          :drivers_licence_state_code => "NSW",
          :drivers_licence_number => "1234567890",
          :drivers_licence_date_of_expiry => "2000-01-01",
          :drivers_licence_card_number => "1234567890",
          :passport_country_code => "AUS",
          :passport_number => "1234567890",
          :name_at_citizenship => {
            :family_name => "Potter",
            :first_given_name => "Harry",
            :other_given_name => "James"
          },
          :place_of_birth => "Little Whinging",
          :country_of_birth => "AUS",
          :medicare_card_number => "1234567890",
          :medicare_reference_number => "1",
          :birth_cert_reg_number => "12345679890",
          :birth_cert_reg_state =>"NSW",
          :birth_cert_reg_date => "1980-08-02",
          :birth_cert_reg_name => {
            :family_name => "Potter",
            :first_given_name => "Harry",
            :other_given_name => "James"
          },
          :marriage_cert_reg_number => "1234567890",
          :marriage_cert_reg_state => "NSW",
          :marriage_cert_reg_year => "2000",
          :marriage_date => "2000-02-02",
          :brides_name => {
            :family_name => "Wesley",
            :first_given_name => "Ginny"
          },
          :grooms_name => {
            :family_name => "Potter",
            :first_given_name => "Harry",
            :other_given_name => "James"
          },
          :device_intelligence_org_id => "org-abc",
          :device_intelligence_session_id => "X123"
        }

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

  