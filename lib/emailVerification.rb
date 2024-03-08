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

    def send_otp(otp_send_req, opts = nil)

      opt = SingleVerifyReqOpts.new
      opt = opts.last unless opts.nil? || opts.empty?
      qp ={}
      if @api_key || opt.api_key
        api_key = opt.api_key || @api_key
        qp['apikey'] = api_key
      end

      t_url = prepare_url('https://mslm.io/api/otp/v1/send', qp, opt)
      puts "Url #{t_url}"
      puts otp_send_req.to_json

      otp_send_resp = req_and_resp('POST', t_url, otp_send_req, opt)
      return otp_send_resp
    end

    def verify(otp_token_verify_req, opts = nil)
      opt = SingleVerifyReqOpts.new
      opt = opts.last unless opts.nil? || opts.empty?
      opt.disable_url_encode = true if opt.disable_url_encode.nil?

      qp = {}
      if @api_key || opt.api_key
        api_key = opt.api_key || @api_key
        qp['apikey'] = api_key
      end

      t_url = prepare_url('https://mslm.io/api/otp/v1/token_verify', qp, opt)
      puts "Url #{t_url}"

      otp_token_verify_resp = req_and_resp('POST', t_url, otp_token_verify_req, opt)
      return otp_token_verify_resp
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

      if _method == 'POST'
        request = Net::HTTP::Post.new(uri.request_uri)
        request.body = _data.to_json
        request.content_type = 'application/json'
      elsif _method == 'GET'
        request = Net::HTTP::Get.new(uri.request_uri)
      else
        return "Unsupported HTTP method: #{_method}"
      end

      response_data = http.request(request)

      if _method == 'POST' and response_data.code.to_i == 200
        json_response = JSON.parse(response_data.body)
        return json_response

      elsif response_data.code.to_i == 200
        json_response = JSON.parse(response_data.body)
        response = [json_response["email"],json_response["username"],json_response["domain"],json_response["malformed"],json_response["suggestion"],json_response["status"],json_response["has_mailbox"],json_response["accept_all"],json_response["disposable"],json_response["free"],json_response["role"],json_response['mx']]
        return response
        
      else
        return "HTTP #{response_data.code}: #{response_data.message}"
      end
    end
  end
end
