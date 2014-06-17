require 'spec_helper'

describe VedaIdmatrix do
	describe VedaIdmatrix::Request do
    it { should validate_presence_of(:entity) }

    # describe "with no developer veda idmatrix config file" do
    #   describe "VedaIdmatrix::Request.access" do
    #     it "returns error message for [:url]" do
    #       expect(VedaIdmatrix::Request.access[:url]).to eq("Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.")
    #     end

    #     it "returns error message for [:access_code]" do
    #       expect(VedaIdmatrix::Request.access[:access_code]).to eq("Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.")
    #     end

    #     it "returns error message for [:password]" do
    #       expect(VedaIdmatrix::Request.access[:password]).to eq("Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.")
    #     end
    #   end
    # end

    describe "with developer veda idmatrix config file" do
      # FileUtils.cp('lib/templates/veda_idmatrix.yml', 'lib/config/veda_idmatrix.yml')
      describe "lib/config/veda_idmatrix.yml" do
        it "is included in the gitignore file" do
          expect(File.read('.gitignore')).to include('lib/config/veda_idmatrix.yml')
        end
      end


      # describe "with no filled in values" do
      #   describe "VedaIdmatrix::Request.access" do
      #     it "returns error message for [:url]" do
      #       expect(VedaIdmatrix::Request.access[:url]).to eq("")
      #     end

      #     it "returns error message for [:access_code]" do
      #       expect(VedaIdmatrix::Request.access[:access_code]).to eq("")
      #     end

      #     it "returns error message for [:password]" do
      #       expect(VedaIdmatrix::Request.access[:password]).to eq("")
      #     end
      #   end
      # end
      # FileUtils.rm('lib/config/veda_idmatrix.yml')
    end

	end
end