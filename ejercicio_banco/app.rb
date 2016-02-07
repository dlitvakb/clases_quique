require 'webrick'
require 'json'
require 'slim'

require './banco'

def render_slim(template, data = {})
  template_path = File.join(File.dirname(__FILE__), 'templates', "#{template}.html.slim")
  Slim::Template.new(nil, {}) { File.open(template_path).readlines().join('') }.render({}, data)
end

def banco_path
  File.join(File.dirname(__FILE__), 'data', 'banco.json')
end

def json_read(raw)
  JSON.parse(raw, symbolize_names: true)
end

def banco
  Banco.from_json(json_read(File.open(banco_path).readlines().join('')))
end

def guardar_banco(banco)
  File.write(banco_path, JSON.pretty_generate(banco))
end

if __FILE__ == $0
  class IndexController < WEBrick::HTTPServlet::AbstractServlet
    def do_GET(_request, response)
      response.status = 200
      response.body = render_slim('index', banco: banco.to_json, banco_json: JSON.dump(banco.to_json))
    end
  end

  class BancoController < WEBrick::HTTPServlet::AbstractServlet
    def do_POST(request, response)
      data = json_read(request.body)
      guardar_banco(data[:banco])
      response.status = 201
      response.body = JSON.dump(banco.to_json)
      response['Content-Type'] = 'application/json'
    end
  end

  @server = WEBrick::HTTPServer.new(Port: 5123)
  @server.mount '/', IndexController
  @server.mount '/banco', BancoController

  @server.start
end
