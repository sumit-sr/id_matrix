class VedaIdmatrix::Request < ActiveRecord::Base
  self.table_name = "veda_idmatrix_requests"
  
  validates :entity, presence: true
  after_initialize :set_defaults

  def self.access
    begin
      dev_config = YAML.load_file( File.expand_path( '../../lib/config/veda_idmatrix.yml', File.dirname(__FILE__) ) )

      {
        :url => dev_config["url"],
        :access_code => dev_config["access_code"],
        :password => dev_config["password"]
      }
    rescue 
      {
        :url => "Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' and fill in access details.",
        :access_code => "Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' and fill in access details.",
        :password => "Copy 'lib/templates/veda_idmatrix.yml' to 'lib/config/veda_idmatrix.yml' and fill in access details."
      }
    end
  end

  def set_defaults
    if self.access.nil? 
      self.access = {
        :url => VedaIdmatrix::Request.access[:url],
        :access_code => VedaIdmatrix::Request.access[:access_code],
        :password => VedaIdmatrix::Request.access[:password]
      }
    end
  end

end