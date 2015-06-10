module Forming
  module Fields
    class Real
      attr_reader :name, :type

      def initialize(name: name, type: nil)
        @name = name
        @type = type || 'text'
      end
    end

    Virtual = Class.new(Real)
  end
end
