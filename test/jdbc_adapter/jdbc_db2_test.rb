require 'java'
require 'lib/jdbc_adapter/jdbc_db2'
require 'test/unit'

class JdbcSpec::DB2Test < Test::Unit::TestCase
  def setup
    @inst = Object.new
    @inst.extend JdbcSpec::DB2
    @column = Object.new
    class <<@column
      attr_accessor :type
    end
  end
  
  def test_quote_decimal
    assert_equal %q{'123.45'}, @inst.quote("123.45")
    @column.type = :decimal
    assert_equal %q{123.45}, @inst.quote("123.45", @column), "decimal columns should not have quotes"
  end
  
  def test_primary_key_generation
    @column.type = :primary_key
    assert_equal 'int generated always as identity (start with 1) primary key', @inst.modify_types({:string => {}, :integer => {}, :boolean => {}})[:primary_key]
  end
  
end
