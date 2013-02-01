module Gears
  class ModelForm < Form
    def self.model klass=nil
      @_model ||= klass
    end

    def initialize instance, opts={}
      if instance.is_a? Hash
        opts = instance
      else
        @instance = instance
      end
      super opts
    end

    def persist!
      if @instance
        @instance.update_attributes attributes
      else
        @instance = self.class.model.create! attributes
      end
    end
  end
end