require 'spec_helper'

describe VedaIdmatrix do
	describe VedaIdmatrix::Request do
    it { should validate_presence_of(:entity) }

	end
end