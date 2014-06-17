class VedaIdmatrix::Request < ActiveRecord::Base
  self.table_name = "veda_idmatrix_requests"
  validates :entity, presence: true

  def self.access
    begin
      File.read('dev_veda_access.yml')
      dev_config = YAML.load_file('dev_veda_access.yml')
      {
        :url => dev_config["url"],
        :access_code => dev_config["access_code"],
        :password => dev_config["password"],
        :subscriber_id => dev_config["subscriber_id"],
        :security_code => dev_config["security_code"],
        :request_mode => dev_config["request_mode"]
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