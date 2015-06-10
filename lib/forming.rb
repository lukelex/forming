require_relative './forming/version'
require_relative './forming/dsl'

module Forming
  def self.included(receiver)
    receiver.extend         DSL::ClassMethods
    receiver.send :include, DSL::InstanceMethods
  end
end
