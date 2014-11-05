require 'uri'

# class ::Hash
#     def deep_merge(second)
#         merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
#         self.merge(second, &merger)
#     end
# end

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
      @params = {}
      if req
        #@params = parse_www_encoded_form(req.body)
        @params = parse_www_encoded_form(req.query_string)
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
        keys = parse_key(k)
        hashes << array_to_hash(keys, v)
      end
      merge(hashes)
    end
    
    def merge(hashes)
      
      final = hashes.shift
      until hashes.count == 0
        hash = hashes.shift
        debugger
        if final.keys.any? {|k| k.include? hash.keys.first}
          final[hash.keys.first] = merge([final[hash.keys.first], hash[hash.keys.first]])
        else
          final.merge(hash)
        end
      end
      final
    end
    
      

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/[\[\]]/) - [""]
    end
    
    def array_to_hash(arr, value)
      hash = {}
      arr.reduce(hash) do |h, m| 
        m == arr.last ? h[m] = value : h[m] = {}
      end
      hash
    end
  end
end
