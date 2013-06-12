require 'uri'
require 'httpclient'

module GeminaboxClient
  class Client
    HEADERS = { 'Accept' => 'text/plain' }.freeze

    attr_reader :url

    def initialize(url)
      extract_username_and_password_from_url!(url)
    end

    def push(gemfile, options={})
      body = { 'file' => File.open(gemfile, 'rb'), 'overwrite' => !!options[:overwrite] }

      response = http_client.post(url_for(:upload), body, HEADERS)

      raise GeminaboxClient::Error, "Error (#{response.code} received)\n\n#{response.body}" if response.status > 300

      response.body
    end

  private

    def http_client
      @http_client ||= initialize_client
    end

    def url_for(path)
      @url + path.to_s
    end

    def initialize_client
      HTTPClient.new(:agent_name => "GemClient #{VERSION}").tap do |client|
        if @username or @password
          client.set_auth(url_for(:upload), @username, @password) 
          client.www_auth.basic_auth.challenge(url_for(:upload)) # Workaround: https://github.com/nahi/httpclient/issues/63
        end

        client.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
        client.send_timeout = 0
        client.receive_timeout = 0
      end
    end

    def extract_username_and_password_from_url!(url)
      uri = URI.parse(url.to_s)

      @username, @password = uri.user, uri.password

      uri.user = uri.password = nil
      uri.path = uri.path + "/" unless uri.path.end_with?("/")

      @url = uri.to_s
    end

  end

end
