require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_method name do
      # through_options = @assoc_options[:name]
      # p through_options
      # source_options  = @assoc_options[:name]
      p "options"
      p "name #{name}, through_name #{through_name}, source_name #{source_name}"
      
      p "class: #{self.class}"
      
      
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      
      p through_options
      p "break"
      p through_options.model_class
      p "end"
      p source_options
      p "end"
      owner_id = self.attributes[through_options.foreign_key]
      p "owner_id: #{owner_id}"
      
      
      query = "
        SELECT
          #{source_options.table_name}.*
        FROM
          #{through_options.table_name}
        JOIN
          #{source_options.table_name}
        ON
          #{through_options.table_name}.#{source_options.foreign_key} = #{source_options.table_name}.id
        WHERE
          #{through_options.table_name}.id = #{owner_id}
      "
      source_options.model_class.new(DBConnection.execute(query).first)
    end
  end
end
