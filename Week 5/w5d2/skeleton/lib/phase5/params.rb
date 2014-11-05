require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = route_params
      [req.body, req.query_string].each do |x|
        @params = merge([@params, parse_www_encoded_form(x)]) if x
      end
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      hashes = []
      URI::decode_www_form(www_encoded_form).each do |k, v|
        hashes << array_to_hash(k.split(/[\[\]]/) - [""], v)
      end
      merge(hashes)
    end

    def array_to_hash(arr, value)
      hash = {}
      arr.reduce(hash) do |h, m| 
        m == arr.last ? h[m] = value : h[m] = {}
      end
      hash
    end

    def merge(hashes)
      final = hashes.shift
      until hashes.count == 0
        hash = hashes.shift
        if final[hash.keys.first]
          final[hash.keys.first] = merge([final[hash.keys.first], hash[hash.keys.first]])
        else
          final = final.merge(hash)
        end
      end
      final
    end
  end
end
