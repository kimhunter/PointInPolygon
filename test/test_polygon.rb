require "pinp"
require "test/unit"

include Pinp

class TestPolygon < Test::Unit::TestCase

  def setup
    points = [Point.new(0,0),Point.new(20,0),Point.new(20,20),Point.new(0,20)]
    @square = Polygon.new points
  end

  def test_points
    assert_equal 4, @square.points.size, "Wrong number of points"
  end

  def test_edges
    assert_equal 4, @square.edges.size, "Wrong number of edges"
  end
  
  def test_contains_crossing_method 
    result = @square.contains_point? Point.new(10,10), :crossing
    assert result, "Point should be in center of square"
    
    result = @square.contains_point? Point.new(25,25), :crossing
    assert !result, "Point should not be inside of square"
  end

  def test_contains_point_winding
    result = @square.contains_point_winding? Point.new(10,10)
    assert result, "Point should be in center of square"

    result = @square.contains_point_winding? Point.new(21,20)
    assert result == false, "Point should not be in square"
  end

  def test_contains
    [:crossing, :winding].each do |algorithm|
      res = @square.contains_point? Point.new(5, 5), algorithm
      assert res, "Point should be in center of square (#{algorithm.to_s})"
      res = @square.contains_point? Point.new(19.9, 19.9), algorithm
      assert res, "Point should be in top corner of square (#{algorithm.to_s})"

      # points not in square
      res = @square.contains_point? Point.new(-20.0, 222.0), :winding
      assert !res, "Point should be outside top corner of square (#{algorithm.to_s})"
    end
  end

  def test_point_is_a_vertex
    assert @square.is_a_vertex?(Point.new(0,0))
    assert @square.is_a_vertex?(Point.new(20,20))
    assert !@square.is_a_vertex?(Point.new(0,21))
    assert !@square.is_a_vertex?(Point.new(-20,21))
    assert !@square.is_a_vertex?(Point.new(20,21))
  end
    
  def test_contains_point
    type = :winding
    result = @square.contains_point? Point.new(5,5), type
    assert result, "Point should be in center of square (#{type})"
    
    result = @square.contains_point? Point.new(25.0,25.0), type
    assert !result, "Point should not be in square (#{type})"
    
    result = @square.contains_point? Point.new(25,10), type
    assert !result, "Point should not be in square (#{type})"
    
    result = @square.contains_point? Point.new(10,25), type
    assert !result, "Point should not be in square (#{type})"

    result = @square.contains_point? Point.new(-10,10), type
    assert !result, "Point should not be in square (#{type})"
    
  end

  def test_parse_points
    points = Polygon.parse_points("0,0\n0,10\n10,10\n10,0")
    assert_equal 4, points.size, "incorrect number of points parsed"
  end
  
  def test_parse_points_trailing_newlines
    points = Polygon.parse_points("0,0\n0,10\n10,10\n10,0\n")
    assert_equal 4, points.size, "incorrect number of points parsed"

    points = Polygon.parse_points("0,0\n0,10\n10,10\n10,0\n")
    assert_equal 4, points.size, "incorrect number of points parsed"

    points = Polygon.parse_points("0,0\n0,10\n10,10\n10,0\n\n")
    assert_equal 4, points.size, "incorrect number of points parsed"
  end
  
end

