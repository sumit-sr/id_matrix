class VedaIdmatrix::Response < ActiveRecord::Base
  self.table_name = "veda_idmatrix_responses"
  belongs_to :request, dependent: :destroy, inverse_of: :response

  serialize :headers
  serialize :struct

  def to_hash
    if self.xml
      Hash.from_xml(self.xml)
    else
      "No hash was created because there was no xml"
    end
  end

  def error
    if self.xml && !self.success?
      self.xml
    else
      "No error"
    end
  end


end
