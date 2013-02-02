module Gears
  class ModelForm < Form
    def self.model klass=nil
      @@model ||= klass
    end

    def initialize instance=nil, attrs={}
      (instance, attrs = nil, instance) if instance.is_a? Hash
      super attrs
      self.for instance
    end

    def for instance
      @instance = instance
      check_instance_model
    end

    def persist!
      if @instance
        @instance.update_attributes attributes
      else
        @instance = self.class.model.create! attributes
      end
    end

    private #-----------

    def check_instance_model
      model = self.class.model
      if @instance
        raise TypeError.new("Instance #{@instance} is not a #{model}") unless @instance.is_a? model
      else
        raise TypeError.new("Please specify a model class to create") unless model.is_a? Class
      end
    end
  end
end