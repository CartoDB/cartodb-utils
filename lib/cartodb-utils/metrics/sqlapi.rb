module CartoDBUtils
  module Metrics
  
    class SQLAPI

      SQLAPI_PATH = "/api/v1/sql" 
      
      EVENT_AGGREGATION_TEMPLATE = <<-EOS
      WITH upsert AS (
        UPDATE events 
        SET value=##VALUE##
        WHERE timestamp='##TIMESTAMP##'
        AND tags='##TAGS##' 
        RETURNING *
      )
      INSERT INTO events (timestamp, value, tags) 
        SELECT '##TIMESTAMP##', ##VALUE##, '##TAGS##' 
        WHERE NOT EXISTS (SELECT * FROM upsert);
      EOS
      
      GAUGE_AGGREGATION_TEMPLATE = <<-EOS
      WITH upsert AS (
        UPDATE gauges
        SET value=##VALUE##
        WHERE timestamp='##TIMESTAMP##'
        AND tags='##TAGS##' 
        RETURNING *
      )
      INSERT INTO gauges (timestamp, value, tags) 
        SELECT '##TIMESTAMP##', ##VALUE##, '##TAGS##' 
        WHERE NOT EXISTS (SELECT * FROM upsert);
      EOS

      SLA_AGGREGATION_TEMPLATE = <<-EOS
      WITH upsert AS (
        UPDATE sla
        SET value=##VALUE##
        WHERE timestamp='##TIMESTAMP##'
        AND username='##USERNAME##'
        AND type='##TYPE##'
        RETURNING *
      )
      INSERT INTO sla (timestamp, username, type, value)
        SELECT '##TIMESTAMP##', '##USERNAME##', '##TYPE##', ##VALUE##
        WHERE NOT EXISTS (SELECT * FROM upsert);
      EOS

      SERVICE_STATUS_AGGREGATION_TEMPLATE = <<-EOS
      WITH upsert AS (
        UPDATE service_status
        SET value=##SERVICE_STATUS##
        WHERE timestamp='##TIMESTAMP##'
        AND cloud_name='##CLOUD_NAME##'
        AND host_group='##HOST_GROUP##'
        AND host='##HOST##'
        AND service='##SERVICE##'
        RETURNING *
      )
      INSERT INTO service_status (timestamp, cloud_name, host_group, host, service, service_status)
        SELECT '##TIMESTAMP##', '##CLOUD_NAME##', '##HOST_GROUP##', '##HOST##', '##SERVICE##', ##SERVICE_STATUS##
        WHERE NOT EXISTS (SELECT * FROM upsert);
      EOS

      def initialize(options = {})
        @api_key = options[:api_key]
        @cartodb_domain = options[:cartodb_domain]
        @sqlapi_url = "https://#{@cartodb_domain}#{SQLAPI_PATH}?api_key=#{@api_key}"
      end

      def request(sql_query)
        response_code, body = CartoDBUtils.http_request(@sqlapi_url, 1, {:params => {:q => sql_query}, :http_method => :post}) 
        return body
      end

    end
  end
end
