# Veda Idmatrix

Ruby gem to make requests to Veda IDmatrix identification verification service. Website: [https://www.veda.com.au](https://www.veda.com.au/)

## Installation

Add this line to your application's Gemfile:

    gem 'veda_idmatrix'

And then execute:

    $ bundle

Then run install generator:

	rails g veda_idmatrix:install

Then run migrations:

    rake db:migrate


## Usage

### Request


    request = VedaIdmatrix::Request.create(ref_id: 123, access: access_hash, entity: entity_hash, enquiry: enquiry_hash)

Attributes for access_hash:

    {
        :url => config["url"],
        :access_code => config["access_code"],
        :password => config["password"]
    }

Attributes for entity_hash:

    {
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
            :postcode => "2999"
            },
        :home_phone_number => "0312345678",
        :mobile_phone_number => "0487654321",
        :email_address => "harry.potter@example.com",
        :drivers_licence_state_code => "NSW",
        :drivers_licence_number => "1234567890",
        :drivers_licence_card_number => "1234567890"
    }

    if unformatted address is present as below it will be used instead of the formatted address above
    :current_address => {:unformatted_address => "Potter Manor 3/4 Privet Drive Little Whinging NSW 2999"}


    Attributes for enquiry_hash

    {
        :client_reference => "123456",
        :reason_for_enquiry => "Test"
    }

#### Instance Methods:

    request.access - Access Hash
    request.entity - Entity Hash
    request.soap - Soap envelope of request
    request.xml - XML message body of request
    request.post - Post to Veda Idmatrix

### Response
	post = request.post
    response = VedaIdmatrix::Response.create(xml: post.body, headers: post.headers, code: post.code, success: post.success?, request_id: request.id)

#### Instance Methods:

    response.as_hash - Hash of whole response
    response.xml - XML of response
    response.code - Response status code
    response.headers - Response headers
    response.success? - Returns true or false (based on Httparty response)
    response.error - Response errors if any


## Contributing

1. Fork it ( http://github.com/easylodge/veda_idmatrix/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. See dev.rb file in root
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
