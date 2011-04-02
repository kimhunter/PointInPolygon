# Copyright (C) 2011 by Kim Hunter
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module PinP
  
  class Polygon
    attr_accessor :points, :edges

    def initialize p
      @edges = []
      @points = p
      build_edges
    end

    # Load edges from all points
    def build_edges
      i = @points.count - 1

      while i > 0
        @edges.push Edge.new(@points[i], @points[i-1])
        i -= 1
      end
      # add the last edge to complete the polygon
      @edges.push Edge.new(@points.first, @points.last)
    end

    #expected input is newline separated "long,lat\nlong,lat" "2.3,-23.5\n323.2,232\n"
    def parse_points pnts
      pnts.split("\n").each do |s|
        tmp = s.split(',')
        @points.push Point.new(tmp[0].to_f, tmp[1].to_f)
      end
    end

    def contains_point? p, method=:crossing
      return (method == :crossing) ? contains_point_crossing?(p) : contains_point_winding?(p)
    end

    # See this
    # http://softsurfer.com/Archive/algorithm_0103/algorithm_0103.htm
    def contains_point_crossing? point
      count = 0;
      @edges.each_with_index do |edge,i| 
        if (edge.upward_crossing? point) || (edge.downward_crossing? point)
          vt = (point.latitude - edge.start_point.latitude) / edge.rise 
          count += 1 if point.longitude < edge.start_point.longitude + vt * (edge.run)   
        end
      end
      count.odd?
    end

    def contains_point_winding? point
      counter = 0
      @edges.each do |edge|
        if edge.upward_crossing?(point) && edge.point_is_left?(point) 
          counter += 1 
        elsif edge.downward_crossing?(point) && edge.point_is_right?(point)
            counter -= 1
        end    
      end
      return counter != 0
    end

    def to_s
      "Polygon #{@points.count} Edges #{@edges.count}"
    end

  end


  class Point
    attr_reader :longitude, :latitude
    alias :x :longitude
    alias :y :latitude
    
    def initialize(long, lat)
      @longitude = long
      @latitude = lat
    end

  end

  class Edge
    attr_accessor :start_point, :end_point
    def initialize a,b
      @start_point = a
      @end_point = b
    end

    def upward_crossing? point
      @start_point.latitude <= point.latitude && @end_point.latitude > point.latitude
    end

    def downward_crossing? point
      @start_point.latitude > point.latitude && @end_point.latitude <= point.latitude
    end

    def rise
      @end_point.latitude - @start_point.latitude
    end

    def run
      @end_point.longitude - @start_point.longitude
    end
    
    # tests if a point is Left On or Right of an infinite edge.
    # Returns: >0 if point is left of edge
    #          =0 if point is on the edge
    #          <0 if point is right of edge
    def is_point_left_on_or_right point
      (@end_point.latitude - @start_point.latitude) * (point.longitude - @start_point.longitude)           - (point.latitude - @start_point.latitude) * (@end_point.longitude - @start_point.longitude)
    end
    
    
    def point_is_left? p
      is_point_left_on_or_right(p) > 0
    end
    
    def point_is_right? p
      is_point_left_on_or_right(p) < 0      
    end
    
    def point_is_on? p
      is_point_left_on_or_right(p) == 0
    end
    
    def to_s
      "Edge #{@start_point} -> #{@end_point}"
    end
  end

end

### =================
### = EXAMPLE USAGE =
### =================
# 
# points = []
# points << PinP::Point.new(0,0)
# points << PinP::Point.new(20,0)
# points << PinP::Point.new(20,20)
# points << PinP::Point.new(0,20)
# 
# pgon = PinP::Polygon.new points
# puts pgon.contains_point? PinP::Point.new(10, 10)
# puts pgon.contains_point? PinP::Point.new(20.1 ,10)
