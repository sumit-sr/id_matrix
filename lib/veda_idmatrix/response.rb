class VedaIdmatrix::Response < ActiveRecord::Base
  self.table_name = "veda_idmatrix_responses"
  belongs_to :request, dependent: :destroy

  after_initialize :to_struct

  def to_struct
    if self.xml && self.success?
      self.struct = RecursiveOpenStruct.new(self.to_hash) #["Envelope"]
    else
      "No struct was created, run error"
    end
  end

  def to_hash
    if self.xml
      Hash.from_xml(self.xml)
    else
      "No hash was created because there was no xml"
    end
  end


end