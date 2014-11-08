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

