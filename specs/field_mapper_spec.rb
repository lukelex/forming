require 'rspec'
require_relative '../lib/forming/field_mapper'

RSpec.describe Forming::FieldMapper do
  let(:form) { OpenStruct.new(exposures: [], virtual_exposures: []) }

  subject { Forming::FieldMapper.new(form) }

  it { expect(subject).to respond_to :submit_field }

  context 'given single level model' do
    let(:country_field) { OpenStruct.new(name: 'country', type: 'text') }
    let(:city_field) { OpenStruct.new(name: 'city', type: 'text') }
    let(:form_config) do
      OpenStruct.new(exposures: [country_field, city_field], virtual_exposures: [])
    end

    subject { Forming::FieldMapper.new form_config }

    it do
      expect(subject).to respond_to :country_field
      expect(subject).to respond_to :city_field
    end
  end
end
