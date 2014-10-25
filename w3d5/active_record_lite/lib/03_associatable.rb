require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'
# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    model_class.table_name || @class_name.tableize
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @class_name   = options[:class_name]  ||= name.to_s.camelcase
    @foreign_key  = options[:foreign_key] ||= "#{name.to_s.singularize}_id".to_sym
    @primary_key  = options[:primary_key] ||= :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @class_name       = options[:class_name]      ||= name.to_s.camelcase.singularize
    @self_class_name  = options[:self_class_name] ||= self_class_name
    @foreign_key      = options[:foreign_key]     ||= "#{self_class_name.to_s.downcase.singularize}_id".to_sym
    @primary_key      = options[:primary_key]     ||= :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    self.assoc_options[name] = BelongsToOptions.new(name, options)
    define_method name do
      #cat belongs to
      #owner
      #class_name = human
      #foreign_key = owner_id
      #primary_key = id
      association = BelongsToOptions.new(name, options)
      
      # name = class_name
      association.model_class.where(id: self.send(association.foreign_key)).first
    end
  end

  def has_many(name, options = {})
    define_method name do
      # Human has many
      # cats
      # class_name = cat
      # foreign_key = owner_id
      # primary_key = id
      association = HasManyOptions.new(name, self.class, options)
      # name = class_name || name = "cat"
      association.model_class.where("#{association.foreign_key}".to_sym => self.send(:id))
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
  # Mixin Associatable here...
end