
Implementation in ruby of the algorithm found in [Point in Polygon Winding Number Inclusion](http://softsurfer.com/Archive/algorithm_0103/algorithm_0103.htm#Crossing%20Number "Original Algorithm")

Usage
-----
    require "pinp"
    points = []
    points << PinP::Point.new(0,0)
    points << PinP::Point.new(20,0)
    points << PinP::Point.new(20,20)
    points << PinP::Point.new(0,20)
    
    pgon = PinP::Polygon.new points
    puts pgon.contains_point? PinP::Point.new(10, 10)
    puts pgon.contains_point? PinP::Point.new(20.1 ,10)



###Todo
* more testing
* add option to test if point is on any edge of the polygon
