require "rake"

Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  # s.rubygems_version = '1.3.5'

  s.name              = 'pinp'
  s.version           = '0.1.0'
  s.date              = '2011-04-03'

  s.summary     = "Point in Polygon."
  s.description = "Find a point in a polygon based on Crossing Number Inclusion."

  s.authors  = ["Kim Hunter"]
  s.email    = 'bigkm1@gmail.com'
  s.homepage = 'https://github.com/bigkm/PointInPolygon'

  s.require_paths = %w[lib]
  # = MANIFEST =
  s.files = FileList["lib/*.rb"]
  # = MANIFEST =
  s.test_files = FileList["test/*.rb"]
end
