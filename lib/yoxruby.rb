require "yoxruby/version"
require "httpclient"
require "json"

module Yoxruby
    class ConnectionError < StandardError; end
    class ClientError < StandardError; end
    class Client
        attr_writer :api_token, :access_token

        API_BASE_URL = "https://api.justyo.co"

        def initialize(api_token=nil, access_token=nil)
            if api_token != nil
                @api_token = api_token
            end
            if access_token !=nil
                @access_token = access_token
            end
            @httpclient = HTTPClient.new
        end

        def set_api_token(username, password)
            url = API_BASE_URL + "/rpc/login"
            res = http_wrapper { @httpclient.post(url, {username: username, password: password}) }
            @api_token = res['api_token']
            res
        end

        def yoall(**options)
            res = just_yo("/yoall/", options)
        end

        def yo(**options)
            res = just_yo("/yo/", options)
        end

        def unread
            url = API_BASE_URL + "/yos/?access_token=#{@access_token}"
            res = http_wrapper {@httpclient.get(url)}
        end

        def me
            url = API_BASE_URL + "/me/?access_token=#{@access_token}"
            res = http_wrapper {@httpclient.get(url)}
        end

        def contacts
            url = API_BASE_URL + "/contacts/?access_token=#{@access_token}"
            res = http_wrapper {@httpclient.get(url)}
        end

        def add_contacts(username)
            url = API_BASE_URL + "/contacts/?access_token=#{@access_token}"
            res = http_wrapper {@httpclient.post(url, {username: username})}
        end

        def subscribers
            url = API_BASE_URL + "/subscribers_count/?api_token=#{@api_token}"
            res = http_wrapper {@httpclient.get(url)}
        end


        private
        def http_wrapper(&block)
            begin
                res = block.call
                res = JSON.parse res.body
                raise ClientError.new(res['error']) if res.has_key? "error"
            rescue HTTPClient::TimeoutError => e
                raise ConnectionError.new(e.message)
            rescue HTTPClient::BadResponseError => e
                raise ConnectionError.new(e.message)
            rescue HTTPClient::ConfigurationError => e
                raise ClientError.new(e.message)
            end
            res
        end
        def just_yo(endpoint, **options)
            url = API_BASE_URL + endpoint
            res = http_wrapper {
                @httpclient.post(url, { username: options[:username],
                                        api_token: @api_token,
                                        link: options[:link],
                                        location: options[:location],
                                        text: options[:text]},
                                        response_pair: options[:response_pair])
            }
        end
    end
end
