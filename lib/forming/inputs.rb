module Forming
  require_relative './enhancements'
  using Enhancements

  module Inputs
    class TextField
      def initialize(model, field, value)
        @model = model
        @field = field
        @value = value
      end

      class << self
        attr_accessor :type

        def type(name = nil)
          if name
            @type = name
          else
            @type
          end
        end
      end

      def render
        "<input #{type} #{name} #{value} />"
      end

      private

      def type
        "type=\"#{@field.type}\""
      end

      def name
        "name=\"#{@model.class.name.underscore}[#{@field.name}]\""
      end

      def value
        "value=\"#{@value}\""
      end
    end
  end
end
