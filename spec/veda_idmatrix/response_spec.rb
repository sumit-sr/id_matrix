require 'spec_helper'

describe VedaIdmatrix::Response do
  it { should belong_to(:request).dependent(:destroy) }
  # it { should validate_presence_of(:request) }
  # it { should validate_presence_of(:xml) }
  # it { should validate_presence_of(:code) }
  # it { should validate_presence_of(:headers) }
  # it { should validate_presence_of(:success) }

  before(:all) do
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
  end

    
  describe "created by request.post with valid access details" do

    before(:all) do
      @request = VedaIdmatrix::Request.new(entity: @entity_hash) 
      @post = @request.post
      @response = VedaIdmatrix::Response.create(xml: @post.body, headers: @post.headers, code: @post.code, success: @post.success?, request_id: @request.id)
    end

    describe "is valid" do
      it "returns true" do
        expect(@response.valid?).to be(true)
      end

      # it "has all the details" do
      #   expect(@response).to be(nil)
      # end
    end

    describe ".code" do
      it "returns status code" do
        expect(@response.code).to be(200)
      end  
    end

    describe ".headers" do
      it "returns headers" do
        expect(@response.headers).to include("content-type")
      end  
    end

    describe ".success?" do
      it "returns boolean of post action" do
        expect(@response.success?).to be(true)
      end  
    end

    describe ".request_id" do
      it "returns request_id" do
        expect(@response.request_id).to eq(@request.id)
      end  
    end

    describe ".xml" do
      it "returns xml response body" do
        expect(@response.xml).to include('<?xml version="1.0" encoding="UTF-8"?>')
      end  
    end

    describe ".to_struct" do
      it "returns struct of response body" do
        expect(@response.to_struct.class).to be(RecursiveOpenStruct)
      end

      it "sets .struct" do
        @response.to_struct
        expect(@response.struct).to_not be(nil)
      end

      it "runs after initialize" do
        expect(@response.struct).to_not be(nil)
      end
    end

    describe ".error" do
      it "returns message" do
        expect(@response.error).to eq("No error")
      end
    end
  
  end

  describe "created by request.post with invalid access details" do

    before(:all) do
      @request = VedaIdmatrix::Request.new(access: { 
        url: VedaIdmatrix::Request.access[:url], 
        user_code: "xxxxx",
        password: "xxxxx",
        },entity: @entity_hash)
      @post = @request.post   
      @response = VedaIdmatrix::Response.create(xml: @post.body, headers: @post.headers, code: @post.code, success: @post.success?, request_id: @request.id)
    end

    describe "is valid" do
      
      it "returns true" do
        expect(@response.valid?).to be(true)
      end

      it "can save" do
        expect(@response.save!).to eq(true)
      end
    end

    describe ".code" do
      it "returns server status code" do
        expect(@response.code).to eq(500)
      end
    end

    describe ".headers" do
      it "returns headers" do
        expect(@response.headers).to include("content-type")
      end  
    end

    describe ".success?" do
      it "returns boolean of post action" do
        expect(@response.success?).to be(false)
      end  
    end

    describe ".request_id" do
      it "returns request_id" do
        expect(@response.request_id).to eq(@request.id)
      end  
    end

    describe ".xml" do
      it "returns xml response body" do
        expect(@response.xml).to include('<?xml version="1.0" encoding="UTF-8"?>')
      end  
    end

    describe ".to_struct" do
      it "returns struct of response body" do
        expect(@response.to_struct.class).to eq(String)
      end

      it "returns error message" do
        expect(@response.to_struct).to eq("No struct was created, see .error")
      end
    end

    describe ".error" do
      it "returns message" do
        expect(@response.error).to include("Authentication Required")
      end
    end      
  end
  describe "created by request.post with incorrect password" do

    before(:all) do
      @request = VedaIdmatrix::Request.new(access: { 
        url: VedaIdmatrix::Request.access[:url], 
        access_code: VedaIdmatrix::Request.access[:access_code],
        password: "xxxxx",
        },entity: @entity_hash)
      @post = @request.post
      @response = VedaIdmatrix::Response.create(xml: @post.body, headers: @post.headers, code: @post.code, success: @post.success?, request_id: @request.id)
    end

    it "is valid" do
      expect(@response.valid?).to be(true)
    end

    describe ".code" do
      it "returns server status code" do
        expect(@response.code).to eq(500)
      end
    end

    describe ".headers" do
      it "returns headers" do
        expect(@response.headers).to include("content-type")
      end  
    end

    describe ".success?" do
      it "returns boolean of post action" do
        expect(@response.success?).to be(false)
      end  
    end

    
    describe ".success" do
      it "returns boolean of post action" do
        expect(@response.success).to be(false)
      end  
    end

    describe ".request_id" do
      it "returns request_id" do
        expect(@response.request_id).to eq(@request.id)
      end  
    end

    describe ".xml" do
      it "returns xml response body" do
        expect(@response.xml).to include('<?xml version="1.0" encoding="UTF-8"?>')
      end  
    end

    describe ".to_struct" do
      it "returns string in case of error" do
        expect(@response.to_struct.class).to eq(String)
      end

      it "returns error message" do
        expect(@response.to_struct).to eq("No struct was created, see .error")
      end
    end

    describe ".error" do
      it "returns message" do
        expect(@response.error).to include("Authentication Failed")
      end
    end

      
  end
end