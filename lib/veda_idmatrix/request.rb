class VedaIdmatrix::Request < ActiveRecord::Base
  self.table_name = "veda_idmatrix_requests"
  validates :entity, presence: true
end