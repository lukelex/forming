require_relative './inputs'
require_relative './factories'

module Forming
  class FieldMapper
    def initialize(form)
      @form = form

      delegate_fields_to factory, with: form.exposures
      delegate_fields_to virtual_factory, with: form.virtual_exposures
    end

    def submit_field
      field = Fields::Virtual.new(name: 'submit', type: 'submit')
      Inputs::TextField.new(@form.model, field, 'submit').render
    end

    private

    def delegate_fields_to(factory, with:)
      with.each do |field|
        define_instance_method "#{field.name}_field" do
          factory.build field
        end
      end
    end

    def define_instance_method(name, &block)
      self.class.instance_eval do
        define_method name, &block
      end
    end

    def factory
      @factory ||= InputFactory.new(@form)
    end

    def virtual_factory
      @virtual_factory ||= VirtualInputFactory.new(@form)
    end
  end
end
