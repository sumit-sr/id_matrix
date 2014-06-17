require 'spec_helper'

describe VedaIdmatrix do
	describe VedaIdmatrix::Request do
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

      describe "with filled in vales" do
        describe "set_defaults" do
        let(:request) { VedaIdmatrix::Request.new } 
          it "sets the access details to the config file values" do
            request.set_defaults
            expect(request.access[:url]).to eq('https://ctaau.vedaxml.com/cta/sys2/idmatrix-v4')
          end

          it "runs set_defaults after initialize" do
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

      end
    end

	end
end