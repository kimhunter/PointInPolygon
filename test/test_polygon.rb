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
    result = @square.contains_point? Point.new(5,5), :crossing
    assert result, "Point should be in center of square"
  end

  def test_contains
    [:crossing, :winding].each do |algorithm|
      res = @square.contains_point? Point.new(5,5), algorithm
      assert res, "Point should be in center of square (#{algorithm.to_s})"
      res = @square.contains_point? Point.new(19.9,19.9), algorithm
      assert res, "Point should be in top corner of square (#{algorithm.to_s})"
    end
  end

  def test_point_is_a_vertex
    assert @square.is_a_vertex?(Point.new(0,0))
    assert @square.is_a_vertex?(Point.new(20,20))
    assert !@square.is_a_vertex?(Point.new(0,21))
    assert !@square.is_a_vertex?(Point.new(-20,21))
    assert !@square.is_a_vertex?(Point.new(20,21))
  end

  def test_contains_winding_method
    result = @square.contains_point? Point.new(5,5), :winding
    assert result, "Point should be in center of square"
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

