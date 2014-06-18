class VedaIdmatrix::Response < ActiveRecord::Base
  self.table_name = "veda_idmatrix_responses"
  belongs_to :request, dependent: :destroy
end