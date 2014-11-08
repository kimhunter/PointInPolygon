require "pinp"
require "test/unit"

include Pinp

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

