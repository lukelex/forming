require 'rspec'
require_relative '../lib/forming/dsl'

RSpec.describe Forming::DSL::ClassMethods do
  let(:klass) do
    Class.new do
      extend Forming::DSL::ClassMethods
    end
  end

  it 'should contain all class level methods' do
    expect(klass).to respond_to :exposes
    expect(klass).to respond_to :expose
    expect(klass).to respond_to :expose_virtual
  end
end

RSpec.describe Forming::DSL::InstanceMethods do
  let(:klass) do
    Class.new do
      extend Forming::DSL::InstanceMethods
    end
  end

  it 'should contain all instance level methods' do
    expect(klass).to respond_to :render_form
  end
end
