require 'spec_helper'

describe VedaIdmatrix do
	describe VedaIdmatrix::Request do
    it { should validate_presence_of(:entity) }

    describe "with no developer veda idmatrix config file" do
      describe "VedaIdmatrix::Request.access" do
        it "returns error message for [:url]" do
          expect(VedaIdmatrix::Request.access[:url]).to eq("Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.")
        end

        it "returns error message for [:access_code]" do
          expect(VedaIdmatrix::Request.access[:access_code]).to eq("Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.")
        end

        it "returns error message for [:password]" do
          expect(VedaIdmatrix::Request.access[:password]).to eq("Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.")
        end
      end
    end

    # describe "with developer veda config file" do
    #   let(file) 
    # end

    

	end
end