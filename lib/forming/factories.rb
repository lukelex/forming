require_relative './inputs'

module Forming
  class InputFactory
    MAPPING = {
      String => 'text',
      Fixnum => 'number',
      Date => 'date'
    }
    MAPPING.default = 'text'

    def initialize(form)
      @form = form
    end

    def build(field)
      Inputs::TextField
        .new(@form.model, field, value_for(field))
        .render
    end

    private

    def type_for(field)
      type = @form.model.public_send(field.name) || ''
      MAPPING.fetch type.class
    end

    def value_for(field)
      @form.model.public_send field.name
    end
  end

  class VirtualInputFactory < InputFactory
    private

    def type_for(field)
      if @form.model.respond_to?(field.name)
        super field.name
      else
        MAPPING.default
      end
    end

    def value_for(field)
      if @form.model.respond_to?(field.name)
        super field.name
      end
    end
  end
end
