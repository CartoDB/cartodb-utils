Gem::Specification.new do |s|
  s.name        = 'cartodb-utils'
  s.version     = '0.0.4'
  s.date        = '2015-04-20'
  s.summary     = "Ruby CartoDB utils"
  s.description = "Ruby CartoDB utils"
  s.authors     = ["Luis Bosque"]
  s.email       = 'luisico@gmail.com'
  s.files       = [
                    "lib/cartodb-utils.rb", 
                    "lib/cartodb-utils/metrics.rb", 
                    "lib/cartodb-utils/metrics/elasticsearch.rb",
                    "lib/cartodb-utils/metrics/sqlapi.rb"
                  ]
  s.add_dependency 'typhoeus', '>= 0.7.0'
  s.homepage    =
    'https://github.com/lbosque/cartodb-utils'
  s.license       = 'MIT'
end
