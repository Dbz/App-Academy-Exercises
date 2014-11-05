require 'byebug'
module Phase6
  class Route
    attr_reader :pattern, :http_method, :controller_class, :action_name

    def initialize(pattern, http_method, controller_class, action_name)
      @pattern, @http_method, @controller_class, @action_name = pattern, http_method.to_s.downcase, controller_class, action_name
    end

    # checks if pattern matches path and method matches request method
    def matches?(req)
      (req.request_method.to_s.downcase == @http_method && !req.path.scan(@pattern).empty?)
    end

    # use pattern to pull out route params (save for later?)
    # instantiate controller and call controller action
    def run(req, res)
      
      
      matches = req.path.match(@pattern)
      route_params = Hash[ matches.names.zip( matches.captures ) ]
      c = controller_class.new(req, res, route_params)
      c.invoke_action(@action_name)
    end
  end

  class Router
    attr_reader :routes

    def initialize
      @routes = []
    end

    # simply adds a new route to the list of routes
    def add_route(pattern, method, controller_class, action_name)
      @routes << Route.new(pattern, method, controller_class, action_name)
    end

    # evaluate the proc in the context of the instance
    # for syntactic sugar :)
    def draw(&proc)
      # proc.call(Route.instance_eval)
      self.instance_eval proc
    end

    # make each of these methods that
    # when called add route
    [:get, :post, :put, :delete].each do |http_method|
      define_method(http_method) do |pattern, controller_class, action_name|
        add_route(pattern, http_method, controller_class, action_name)
      end
    end
    
      

    # should return the route that matches this request
    def match(req)
      @routes.select do |r|
        !req.path.scan(r.pattern).empty? && req.request_method.to_s.downcase == r.http_method
      end.first
    end

    # either throw 404 or call run on a matched route
    def run(req, res)
      route = match(req)
      route ? route.run(req, res) : res.status = 404
    end
  end
end
