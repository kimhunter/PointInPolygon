require "pinp"
require "test/unit"

include Pinp

class TestPoint < Test::Unit::TestCase
  
  def setup
    @point1 = Point.new(153.3053, -28.531)
    @point2 = Point.new(43.40, 28.502)
  end
 
  def test_x
    assert_equal(153.3053, @point1.x)
    assert_equal(43.40,    @point2.x)
  end
  
  def test_y
    assert_equal(-28.531, @point1.y)
    assert_equal(28.502,  @point2.y)   
  end

end


class TestEdge < Test::Unit::TestCase
  
  def setup
    @v_edge = Edge.new(Point.new(0,0), Point.new(0,10))
    @h_edge = Edge.new(Point.new(0,0), Point.new(10,0))
    @d_edge = Edge.new(Point.new(0,0), Point.new(10,10))
  end
 
  def test_vertical_edge_is_point_left_on_or_right
    assert_equal 0, @v_edge.is_point_left_on_or_right(Point.new(0,0)), "point should be on vertical line"
    assert 0 < @v_edge.is_point_left_on_or_right(Point.new(12,0)), "point should be on right "
    assert 0 > @v_edge.is_point_left_on_or_right(Point.new(-0.2,0)), "point should be on left"
  end
  
  def test_diagonal_edge_is_point_left_on_or_right
    # Diagonal
    assert 0 > @d_edge.is_point_left_on_or_right(Point.new(0,1))
    assert 0 < @d_edge.is_point_left_on_or_right(Point.new(0,-1))
    assert 0 < @d_edge.is_point_left_on_or_right(Point.new(10,0))    
  end
  
  def test_start_end_points
    p1 = Point.new(0,0)
    p2 = Point.new(0,20)
    edge = Edge.new p1, p2
    assert_equal(p1, edge.start_point)
    assert_equal(p2, edge.end_point)
  end
  

  def test_rise
    assert_equal 10, @v_edge.rise ,"Rise is wrong for vertical line"
    assert_equal  0, @h_edge.rise ,"Rise should be 0 for horizontal line"
    assert_equal 10, @d_edge.rise ,"Rise is wrong for diagnal line"
  end

  def test_run
    assert_equal 0,  @v_edge.run, "Vertical line doesn't have run"
    assert_equal 10, @h_edge.run
    assert_equal 10, @d_edge.run
  end

end

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

