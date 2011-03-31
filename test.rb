require "pinp.rb"
require "test/unit"
 
include PinP

class TestPoint < Test::Unit::TestCase
  
  def setup
    @point1 = Point.new(153.3053, -28.531)
    @point2 = Point.new(43.40, 28.502)
  end
 
  def test_longitude
    assert_equal(153.3053, @point1.longitude)
    assert_equal(43.40,    @point2.longitude)
  end
  
  def test_latitude
    assert_equal(-28.531, @point1.latitude)
    assert_equal(28.502,  @point2.latitude)
  end
  
end


class TestEdge < Test::Unit::TestCase
  
  def setup
    @v_edge = Edge.new(Point.new(0,0), Point.new(0,10))
    @h_edge = Edge.new(Point.new(0,0), Point.new(10,0))
    @d_edge = Edge.new(Point.new(0,0), Point.new(10,10))
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

end
