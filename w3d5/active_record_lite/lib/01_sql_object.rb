require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    query = "
      SELECT
        *
      FROM
        #{table_name}"
    
    col = DBConnection.execute2(query)
    col.first.map(&:to_sym)
  end

  def self.finalize!
    cols = self.columns
    cols.each do |col|
      define_method col do
        self.attributes[col]
      end
      define_method(col.to_s + "=") do |arg|
        self.attributes[col] = arg
      end
    end
    
  end

  def self.table_name=(table_name)
    @table_name = table_name.to_s
  end

  def self.table_name
    if @table_name.nil?
      self.table_name=(self)
    end
    @table_name.tableize
  end

  def self.all
    query = "
      SELECT
        *
      FROM
        #{table_name}
    "
    parse_all(DBConnection.execute(query))
  end

  def self.parse_all(results)
    objects = []
    results.each do |hash|
      objects << self.new(hash)
    end
    objects
  end

  def self.find(id)
    query = "
      SELECT
        *
      FROM
        #{table_name}
      WHERE id = #{id}
    "
    parse_all(DBConnection.execute(query)).first
  end

  def initialize(params = {})
    cols = self.class::columns
    p cols
    params.each do |key, value|
      raise "unknown attribute '#{key.to_s}'" unless cols.include? key.to_sym
      self.send("#{key}=", value)
    end
  end

  def attributes
    @attributes ||= Hash.new
  end

  def attribute_values # Didn't use
    self.attributes.values
  end

  def insert
    cols = self.class::columns
    
    insert_into = "#{self.class::table_name} (#{cols[1..-1].join(", ")})"
    question_marks = "(#{(["?"] * (cols.count - 1)).join(", ")})"

    # insert_into = "#{self.class::table_name} (#{cols.join(", ")})"
    # question_marks = "(#{(["?"] * cols.count).join(", ")})"

    query = "
      INSERT INTO
        #{insert_into}
      VALUES
        #{question_marks}
    "
    DBConnection.execute(query, *(@attributes.values))
    self.id = DBConnection.last_insert_row_id
  end

  def update
    cols = self.class::columns

    query = "
      UPDATE
        #{self.class::table_name}
      SET
        #{cols.map { |col| "#{col} = '#{@attributes[col]}'"}.join(", ")}
      WHERE
        id = ?
    "
    DBConnection.execute(query, @attributes[:id])
  end

  def save
    self.attributes[:id].nil? ? self.insert : self.update
  end
end

