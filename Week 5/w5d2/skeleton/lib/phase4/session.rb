require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @cookie = {}
      value = ""
      req.cookies.each do |k|
        @cookie = JSON.parse(k.value) if k.name == '_rails_lite_app'
      end
      
    end

    def [](key)
      @cookie[key]
    end

    def []=(key, val)
      @cookie[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_app', @cookie.to_json)
    end
  end
end
