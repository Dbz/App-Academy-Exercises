require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    values = []
    params.each do |k, v|
      values << "#{k} = '#{v}'"
    end
    query = "
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{values.join(" AND ")}
    "
    parse_all(DBConnection.execute(query))
  end
end

class SQLObject
  extend Searchable
end
