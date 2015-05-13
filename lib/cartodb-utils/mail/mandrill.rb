module CartoDBUtils
  module Mail
  
    class Mandrill

      MANDRILL_URL = "https://mandrillapp.com/api/1.0/messages/send.json"

      def initialize(options = {})
        @mandrill_key = options[:mandrill_key]
      end

      def request(email_data)
        message_data = {
          "key" => @mandrill_key,
          "message" => {
            "text" => email_data["body"],
            "subject" => email_data["subject"],
            "from_name" => email_data["from_name"],
            "from_email" => email_data["from"],
            "to" => email_data["to"].map {|e| {'email' => e}}
          }
        }
        if email_data["body_html"]
          message_data["message"]["html"] = email_data["body_html"]
        end
        if email_data["body_text"]
          message_data["message"]["text"] = email_data["body_text"]
        end

        response_code, body = CartoDBUtils.http_request(
                                MANDRILL_URL, 
                                1, 
                                {
                                  :body => message_data.to_json.to_s, 
                                  :http_method => :post, 
                                  :headers => { "Content-Type" => "application/json" }
                                }
                              ) 
        return body
      end

    end
  end
end
