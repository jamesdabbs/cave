require 'active_model'
require 'virtus'

module Cave
  class Form
    include Virtus
    include ActiveModel::Validations

    class << self

      def fields
        @_fields ||= {}
      end

      def field name, type, opts={}
        name = name.to_sym

        @_fields ||= {}
        @_fields[name] = type

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
      !!save! rescue false
    end

    def persist!
      raise "#{self.class} does not define a persist method"
    end

    private #----------

    def field_coercion
      self.class.fields.each do |name, type|
        value = attributes[name]
        unless value.nil? || value.is_a?(type)
          errors.add name, "should be a(n) #{type}"
        end
      end
    end

  end
end
