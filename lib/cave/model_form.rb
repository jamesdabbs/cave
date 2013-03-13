module Cave
  class ModelForm < Form
    def self.model klass=nil
      @@model ||= klass
    end

    def initialize instance=nil, attrs={}
      (instance, attrs = nil, instance) if instance.is_a? Hash
      super attrs
      self.for instance
    end

    def lookup attr_name
      super || @instance.send(attr_name)
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
      if @instance
        model = self.class.model
        # Pry alters models in such a way that the first check may fail when it 
        # shouldn't. The second should still be fairly safe.
        unless @instance.is_a?(model) || @instance.class.name == model.name
          raise TypeError.new "Instance #{@instance} is not a #{model}"
        end
      else
        raise TypeError.new("Please specify a model class to create") unless model.is_a? Class
      end
    end
  end
end