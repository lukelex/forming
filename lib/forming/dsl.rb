require_relative './fields'
require_relative './field_mapper'

module Forming
  module DSL
    module ClassMethods
      def exposes(*fields)
        @exposures = Array(fields).map do |field|
          Fields::Real.new(name: field)
        end
      end

      def expose(field, type: nil)
        exposures << Fields::Real.new(name: field, type: type)
      end

      def expose_virtual(arg, type:)
        virtual_exposures << Fields::Virtual.new(name: arg, type: type)
      end

      def exposures
        @exposures ||= Set.new
      end

      def virtual_exposures
        @virtual_exposures ||= Set.new
      end
    end

    module InstanceMethods
      attr_reader :model

      def initialize(model)
        @model = model
      end

      def render_form(&block)
        block.call(FieldMapper.new(self))
      end

      def exposures
        self.class.exposures
      end

      def virtual_exposures
        self.class.virtual_exposures
      end
    end
  end
end
