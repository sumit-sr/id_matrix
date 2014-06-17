class VedaIdmatrix::Request < ActiveRecord::Base
  self.table_name = "veda_idmatrix_requests"
  validates :entity, presence: true

  def self.access
    begin
      dev_config = YAML.load_file( File.expand_path( 'lib/config/veda_idmatrix.yml', File.dirname(__FILE__) ) )

      {
        :url => dev_config["url"],
        :access_code => dev_config["access_code"],
        :password => dev_config["password"]
      }
    rescue
      
      {
        :url => "Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.",
        :access_code => "Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details.",
        :password => "Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' fill in access details."
      }
    end
  end

end