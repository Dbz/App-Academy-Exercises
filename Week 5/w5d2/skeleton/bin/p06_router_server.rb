require 'webrick'
require_relative '../lib/phase6/controller_base'
require_relative '../lib/phase6/router'


# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

$cats = [
  { id: 1, name: "Curie" },
  { id: 2, name: "Markov" }
]

$statuses = [
  { id: 1, cat_id: 1, text: "Curie loves string!" },
  { id: 2, cat_id: 2, text: "Markov is mighty!" },
  { id: 3, cat_id: 1, text: "Curie is cool!" }
]

class StatusesController < Phase6::ControllerBase
  def index
    statuses = $statuses.select do |s|
      s[:cat_id] == Integer(params[:cat_id])
    end

    render_content(statuses.to_s, "text/text")
  end
end

class CatsController < Phase6::ControllerBase
  def index
    render_content($cats.to_s, "text/text")
  end
  def new
    @cat = Cat.new
    render :new
  end
  def create
    puts "printing params"
    p params
    $cats << Cat.new(params[:cat]["name"], params[:cat]["owner"])
    invoke_action :index
  end
    
end

class Cat
  attr_accessor :name, :owner
  def initialize(name="", owner="")
    @name, @owner = name, owner
  end
end

router = Phase6::Router.new
router.draw do
  get Regexp.new("^/cats$"), CatsController, :index
  get Regexp.new("^/cats/(?<cat_id>\\d+)/statuses$"), StatusesController, :index
  get Regexp.new("^/cats/new"), CatsController, :new
  post Regexp.new("^/cats"), CatsController, :create
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
