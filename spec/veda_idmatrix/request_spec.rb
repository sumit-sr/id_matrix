require 'spec_helper'


describe VedaIdmatrix::Request do
  it { should have_one(:response).dependent(:destroy) }
  it { should validate_presence_of(:entity) }

  describe "needs developer veda idmatrix config file" do
    describe "VedaIdmatrix::Request.access" do
      it "returns error message for [:url]" do
        expect(VedaIdmatrix::Request.access[:url]).to_not eq("Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.")
      end

      it "returns error message for [:access_code]" do
        expect(VedaIdmatrix::Request.access[:access_code]).to_not eq("Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.")
      end

      it "returns error message for [:password]" do
        expect(VedaIdmatrix::Request.access[:password]).to_not eq("Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.")
      end
    end
  end

  describe "with developer veda idmatrix config file" do
    describe "lib/config/veda_idmatrix.yml" do
      it "is included in the gitignore file" do
        expect(File.read('.gitignore')).to include('lib/config/veda_idmatrix.yml')
      end
    end


    describe "needs filled in values" do
      describe "VedaIdmatrix::Request.access" do
        it "returns url value for [:url]" do
          expect(VedaIdmatrix::Request.access[:url]).to eq('https://ctaau.vedaxml.com/cta/sys2/idmatrix-v4')
        end

        it "returns nil for [:access_code]" do
          expect(VedaIdmatrix::Request.access[:access_code]).to_not eq(nil)
        end

        it "returns nil for [:password]" do
          expect(VedaIdmatrix::Request.access[:password]).to_not eq(nil)
        end
      end
    end

    describe "with filled in values" do
    let(:request) { VedaIdmatrix::Request.new }
      
      describe "without entity hash" do
        it "is not valid" do
          expect(request.valid?).to be(false)
        end

        describe ".access" do
          it "returns not nil" do
            expect(request.access).to_not be(nil)
          end
        end 

        describe ".entity" do
          it "returns nil" do
            expect(request.entity).to be(nil)
          end
        end 

        describe ".to_soap" do
          it "returns error message that entity hash is not set" do
            expect(request.to_soap).to eq("No entity details - set your entity hash")
          end  
        end

        describe ".soap" do
          it "returns nil for soap body" do
            expect(request.soap).to eq(nil)
          end
        end

        describe ".xml" do
          it "returns nil for xml message body" do
            expect(request.xml).to eq(nil)
          end
        end

        describe ".validate_xml" do
          it "returns error message" do
            expect(request.validate_xml).to eq("No xml to validate! - run to_soap")          
          end
        end

        describe ".post" do
          it "return error message" do
            expect(request.post).to eq("No soap envelope to post! - run to_soap")
          end
        end

      end

      describe "with entity hash" do

        entity_hash = {
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

        let(:request) { VedaIdmatrix::Request.new(entity: entity_hash) } 

        


        describe ".set_defaults" do
        
          it "sets the access details to the config file values" do
            request.set_defaults
            expect(request.access[:url]).to eq('https://ctaau.vedaxml.com/cta/sys2/idmatrix-v4')
          end

          it "runs after initialize" do
            expect(request.access[:url]).to eq('https://ctaau.vedaxml.com/cta/sys2/idmatrix-v4')
          end

          it "can specify new access details to override config file" do
            custom_request = VedaIdmatrix::Request.new(access: {
              url: "http://myurl.com",
              user_code: "my_usercode",
              password: "my_password"
              })
            expect(custom_request.access[:url]).to eq("http://myurl.com")
          end

        end

        describe ".access" do
          it "returns not nil" do
            expect(request.access).to_not be(nil)
          end

          it "can save" do
            request.save
            expect(request.access).to_not be(nil)
          end
        end 

        describe ".entity" do
          it "returns not nil" do
            expect(request.entity).to_not be(nil)
          end

          it "can save" do
            request.save
            expect(request.entity).to_not be(nil)
          end
        end

        describe ".schema" do
          it "returns the xsd schema" do
            expect(request.schema).to include('targetNamespace="http://vedaxml.com/vxml2/idmatrix-v4-0.xsd')
          end
        end

        describe ".to_soap" do
          it "returns soap body" do
            expect(request.to_soap).to_not eq("No entity details - set your entity hash")
          end

          it "sets .soap" do
            request.to_soap
            expect(request.soap).to_not eq(nil)
          end 

          it "runs after initialize" do
            expect(request.soap).to_not eq(nil)
          end
        end

        describe ".soap" do
          it "returns soap body" do
            expect(request.soap).to_not eq(nil)
          end
        end

        describe ".xml" do
          it "returns xml message body" do
            expect(request.xml).to_not eq(nil)
          end

          it "includes 'family-name' in xml" do
            expect(request.xml).to include('<idm:family-name>Potter</idm:family-name>')
          end

          it "includes 'first-given-name' in xml" do
            expect(request.xml).to include('<idm:first-given-name>James</idm:first-given-name>')
          end

          it "includes 'other-given-name' in xml" do
            expect(request.xml).to include('<idm:other-given-name>Harry</idm:other-given-name>')
          end

          it "includes 'date-of-birth' in xml" do
            expect(request.xml).to include('<idm:date-of-birth>1980-07-31</idm:date-of-birth>')
          end

          it "includes 'gender' in xml" do
            expect(request.xml).to include('<idm:gender>male</idm:gender>')
          end

          it "includes 'property' in xml" do
            expect(request.xml).to include('<idm:property>Potter Manor</idm:property>')
          end

          it "includes 'unit-number' in xml" do
            expect(request.xml).to include('<idm:unit-number>3</idm:unit-number>')
          end

          it "includes 'street-number' in xml" do
            expect(request.xml).to include('<idm:street-number>4</idm:street-number>')
          end

          it "includes 'street-name' in xml" do
            expect(request.xml).to include('<idm:street-name>Privet</idm:street-name>')
          end
          
          it "includes 'street-type' in xml" do
            expect(request.xml).to include('<idm:street-type>Drive</idm:street-type>')
          end

          it "includes 'suburb' in xml" do
            expect(request.xml).to include('<idm:suburb>Little Whinging</idm:suburb>')
          end

          it "includes 'state' in xml" do
            expect(request.xml).to include('<idm:state>NSW</idm:state>')
          end

          it "includes 'postcode' in xml" do
            expect(request.xml).to include('<idm:postcode>2999</idm:postcode>')
          end

          it "includes 'home-phone-number' in xml" do
            expect(request.xml).to include('<idm:home-phone-number verify="true">0312345678</idm:home-phone-number>')
          end

          it "includes 'mobile-phone-number' in xml" do
            expect(request.xml).to include('<idm:mobile-phone-number verify="true">0487654321</idm:mobile-phone-number>')
          end

          it "includes 'email-address' in xml" do
            expect(request.xml).to include('<idm:email-address>harry.potter@example.com</idm:email-address>')
          end

          it "includes 'drivers-licence-state-code' in xml" do
            expect(request.xml).to include('<idm:state-code>NSW</idm:state-code>')
          end

          it "includes 'drivers-licence-number' in xml" do
            expect(request.xml).to include('<idm:number>1234567890</idm:number>')
          end

        end

        describe ".to_xml_body" do
          it "returns xml string" do
            expect(request.to_xml_body.class).to eq(String)
          end

          it "sets .xml" do
            request.to_xml_body
            expect(request.xml).to_not eq(nil)
          end
        end

        describe ".id_matrix_operation" do
          it "returns hash" do
            expect(request.id_matrix_operation.class).to eq(Hash)
          end
        end

        describe ".validate_xml" do
          it "returns array" do
            expect(request.validate_xml.class).to eq(Array)          
          end
        end

        # describe ".post" do
        #   it "returns 200 status" do
        #     expect(request.post.code).to eq(200)
        #   end
        # end

        




      end
    end
  end

end
