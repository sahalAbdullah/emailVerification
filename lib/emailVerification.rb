require 'uri'
require 'net/http'
require 'json'

module EmailVerification

   class SingleVerifyReqOpts
    attr_accessor :disable_url_encode
    attr_accessor :api_key
  end

  class Client

    def initialize(api_key = nil)
      @api_key = api_key
    end
    def single_verify(email_addr, opts = nil)
      opt = SingleVerifyReqOpts.new
      opt = opts.last unless opts.nil? || opts.empty?
      opt.disable_url_encode = true if opt.disable_url_encode.nil?

      email_addr = URI.encode_www_form_component(email_addr) unless opt.disable_url_encode

      qp = { 'email' => email_addr }
      if @api_key || opt.api_key
        api_key = opt.api_key || @api_key
        qp['apikey'] = api_key
      end

      
      t_url = prepare_url('https://mslm.io/api/sv/v1', qp, opt)
      puts "Url #{t_url}"

      sv_resp = req_and_resp('GET', t_url, nil, opt)
      return sv_resp
    end

    private

    def prepare_url(path, query_params, opts)
      url = path.dup
      url << '?' << URI.encode_www_form(query_params) unless query_params.empty?
      url
    end

    def req_and_resp(_method, _url, _data, _opts)
      uri = URI.parse(_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      request = Net::HTTP::Get.new(uri.request_uri)
      response_data = http.request(request)

      if response_data.code.to_i == 200
        json_response = JSON.parse(response_data.body)
        response = [json_response["email"],json_response["username"],json_response["domain"],json_response["malformed"],json_response["suggestion"],json_response["status"],json_response["has_mailbox"],json_response["accept_all"],json_response["disposable"],json_response["free"],json_response["role"],json_response['mx']]
        return response
      else
        return "HTTP #{response_data.code}: #{response_data.message}"
      end
    end
  end
end
