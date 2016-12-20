require "yoxruby/version"
require "httpclient"
require "json"

module Yoxruby
    class Client
        API_BASE_URL = "http://api.justyo.co"
        def initialize(api_token=nil, access_token=nil)
            if api_token != nil
                @api_token = api_token
            end
            if access_token !=nil
                @access_token = access_token
            end
            @httpclient = HTTPClient.new
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
            res.body
        end

        def me
            url = API_BASE_URL + "/me/?access_token=#{@access_token}"
            res = @httpclient.get(url)
            res.body
        end

        def contacts
            url = API_BASE_URL + "/contacts/?access_token=#{@access_token}"
            res = @httpclient.get(url)
            res.body
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
            res.body
        end
    end
end
