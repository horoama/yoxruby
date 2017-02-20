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
            res = @httpclient.post(url, {username: username, password: password})
            res = JSON.parse(res.body)
            token = ""
            if res.has_key?('api_token')
                token = res['api_token']
            end
            @api_token = token
        end

        def yoall(**options)
            just_yo("/yoall/", options)
        end

        def yo(**options)
            just_yo("/yo/", options)
        end

        def unread
            url = API_BASE_URL + "/yos/?access_token=#{@access_token}"
            res = @httpclient.get(url)
            JSON.parse res.body
        end

        def me
            url = API_BASE_URL + "/me/?access_token=#{@access_token}"
            res = @httpclient.get(url)
            JSON.parse res.body
        end

        def contacts
            url = API_BASE_URL + "/contacts/?access_token=#{@access_token}"
            res = @httpclient.get(url)
            JSON.parse res.body
        end

        def add_contacts(username)
            url = API_BASE_URL + "/contacts/?access_token=#{@access_token}"
            res = @httpclient.post(url, {username: username})
            JSON.parse res.body
        end

        def subscribers
            url = API_BASE_URL + "/subscribers_count/?api_token=#{@api_token}"
            res = @httpclient.get(url)
            JSON.parse res.body
        end


        private
        def just_yo(endpoint, **options)
            url = API_BASE_URL + endpoint
            res = @httpclient.post(url, {username: options[:username],
                                         api_token: @api_token,
                                         link: options[:link],
                                         location: options[:location],
                                         text: options[:text]},
                                         response_pair: options[:response_pair])
            JSON.parse res.body
        end
    end
end
