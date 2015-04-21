require 'cartodb-utils'

sa = CartoDBUtils::Metrics::SQLAPI.new(:cartodb_domain => 'example.cartodb.com', :api_key => '')
result = sa.request("SELECT 5")
puts result

es = CartoDBUtils::Metrics::Elasticsearch.new(:elasticsearch_ip => '127.0.0.1')
result = es.request({'version' => true})
puts result
