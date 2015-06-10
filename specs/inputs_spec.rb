require 'rspec'
require_relative '../lib/forming/inputs'
require 'ostruct'

RSpec.describe Forming::Inputs::TextField do
  context 'given a conforming model' do
    let(:model) do
      Class.new do
        def self.class
          OpenStruct.new(name: 'User')
        end
      end
    end
    let(:field) { OpenStruct.new(name: :city, type: :text) }
    let(:value) { 'Copenhagen' }

    subject { described_class.new model, field, value }

    it 'should contain the all base attributes' do
      input = subject.render
      expect(input).to include 'type="text"'
      expect(input).to include 'name="user[city]"'
      expect(input).to include 'value="Copenhagen"'
    end
  end

  context 'given a model with a complex name' do
    let(:model) do
      Class.new do
        def self.class
          OpenStruct.new(name: 'UserWithComplexName')
        end
      end
    end

    let(:field) { OpenStruct.new(name: :city, type: :text) }
    let(:value) { 'Copenhagen' }

    subject { described_class.new model, field, value }

    it "should properly underscorize the model's class name" do
      expect(subject.render).to include 'name="user_with_complex_name[city]"'
    end
  end
end
