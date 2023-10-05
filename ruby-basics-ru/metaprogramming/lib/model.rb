# frozen_string_literal: true
#
# BEGIN
module Model
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attribute(name, options = {})
      attribute_name = name.to_sym
      attribute_type = from_sym_to_class(options[:type]) || Object
      default_value = options[:default]

      define_method(attribute_name) do
        value = instance_variable_get("@#{attribute_name}")
        if value.nil?
          value = default_value
        else
          value.is_a?(attribute_type) ? value : attribute_type.new(value)
        end
      end

      define_method("#{attribute_name}=") do |value|
        if attribute_type == DateTime
          instance_variable_set("@#{attribute_name}", attribute_type === value ? value : DateTime.parse(value))
        else

          instance_variable_set("@#{attribute_name}", attribute_type === value ? value : attribute_type.new(value))
        end
      end
    end

    def from_sym_to_class(sym)
      if sym == :integer
        Integer
      elsif sym == :string
        String
      elsif sym == :datetime
        DateTime
      end
    end

    def filter_attributes(attributes)
      attributes.select { |name| method_defined?("#{name}=") }
    end
  end

  def initialize(attributes = {})
    self.class.filter_attributes(attributes).each do |name, value|
      send("#{name}=", value)
    end
  end

  def attributes
    attr_hash = {}
    self.class.filter_attributes(instance_variables.each { |name| attr_hash[name[1..-1].to_sym] = instance_variable_get(name) })
    attr_hash
  end

end

# END