require_relative './inputs'
require_relative './factories'

module Forming
  class FieldMapper
    def initialize(form)
      @form = form

      form.exposures.each do |field|
        self.class.instance_eval do
          define_method "#{field.name}_field" do
            factory.build(field)
          end

          define_method field.name do
            @form.model.public_send(field.name)
          end
        end
      end

      form.virtual_exposures.each do |field|
        self.class.instance_eval do
          define_method "#{field.name}_field" do
            virtual_factory.build(field)
          end

          define_method field.name do
            if @form.model.respond_to?(field.name)
              @form.model.public_send(field.name)
            end
          end
        end
      end
    end

    def submit_field
      field = Fields::Virtual.new(name: 'submit', type: 'submit')
      Inputs::TextField.new(@form.model, field, 'submit').render
    end

    private

    def factory
      @factory ||= InputFactory.new(@form)
    end

    def virtual_factory
      @virtual_factory ||= VirtualInputFactory.new(@form)
    end
  end
end
