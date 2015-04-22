require_relative 'cartodb-utils/metrics.rb'
require_relative 'cartodb-utils/mail.rb'
require 'json/ext'
require 'openssl'
require 'json'
require 'typhoeus'

OpenSSL::SSL.send :remove_const, :VERIFY_PEER
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module CartoDBUtils

  MAX_REQUEST_RETRY = 3

  def self.http_request(url, request_retry = 1, extra_options = {})
    http_method = extra_options[:http_method] || :get
    if http_method == :post
      body = extra_options[:body] || nil
    end
    params = extra_options[:params] || nil
    headers = extra_options[:headers] || nil
    expected_responses = extra_options[:expected_responses] || [200]
    request = Typhoeus::Request.new(
      url,
      method: http_method.to_sym,
      body: body,
      params: params,
      headers: headers
    )
    response = request.run
    if expected_responses.include?(response.code)
      return response.code, response.body
    else
      if request_retry < MAX_REQUEST_RETRY
        sleep request_retry
        return http_request(url, request_retry + 1, extra_options)
      else
        raise(response.body)
      end
    end
  end

end
