require 'active_model'
require 'virtus'

module Cave
  class Form
    include Virtus
    include ActiveModel::Validations

    extend ActiveModel::Naming
    include ActiveModel::Conversion

    class << self

      def fields
        @_fields ||= {}
      end

      def field name, type, opts={}
        name = name.to_sym

        @_fields ||= {}
        @_fields[name] = Field.new(name, type, 
          opts.delete(:label), 
          opts.delete(:help)
        )

        attribute name, type

        confirm = false
        opts.each do |k,v|
          validates name, {k => v}
          confirm ||= (k == :confirmation && v)
        end

        if confirm
          conf_opts = opts[:presence] ? { presence: true } : {}
          field "#{name}_confirmation", type, conf_opts
        end
      end

      def bind *args
        f = new *args
        f.instance_eval { @bound = true }
        f
      end

    end

    validate :field_coercion

    def initialize attrs={}
      super
      bind attrs unless attrs.empty?
    end

    def bind attrs={}
      self.attributes = (attributes || {}).merge attrs
      @bound = true
    end

    def lookup attr_name
      send attr_name
    end

    def bound?
      @bound
    end

    def unbound?
      !@bound
    end

    def save!
      raise Cave::ValidationError.new errors.full_messages.join(',') unless valid?
      persist!
    end

    def save
      begin
        save!
        true
      rescue Cave::ValidationError
        false
      end
    end

    def persisted?
      false
    end

    def persist!
      raise "#{self.class} does not define a persist method"
    end

    private #----------

    def field_coercion
      self.class.fields.each do |name, field|
        field.type
        value = attributes[name]
        unless value.nil? || coercable?(value, field.type)
          errors.add name, "should be a(n) #{field.type}"
        end
      end
    end

    def coercable? value, type
      if value.is_a? type
        true
      elsif type.instance_methods.include? :value_coerced?
        type.new('').value_coerced? value
      else
        false
      end
    end

  end
end
