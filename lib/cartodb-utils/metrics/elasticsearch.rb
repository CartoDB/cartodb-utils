module CartoDBUtils
  module Metrics
  
    class Elasticsearch

      ELASTICSEARCH_PATH = "/_search" 

      def initialize(options = {})
        puts options
        @elasticsearch_ip = options[:elasticsearch_ip]
        @elasticsearch_port = options[:elasticsearch_port] || '9200'
        @elasticsearch_url = "http://#{@elasticsearch_ip}:#{@elasticsearch_port}#{ELASTICSEARCH_PATH}"
      end

      def request(elasticsearch_query)
        response_code, body = CartoDBUtils.http_request(@elasticsearch_url, 1, {:body => elasticsearch_query.to_json, :http_method => :post, :headers => {"Content-Type" => "application/json"}}) 
        return body
      end

    end
  end
end
