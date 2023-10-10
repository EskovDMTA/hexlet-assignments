# frozen_string_literal: true

require 'rack'

class Router
  def call(env)
    request = Rack::Request.new(env)
    response = handle_request(request)
    response
  end

  private

  def handle_request(request)
    case request.path
    when '/'
      handle_root_route(request)
    when '/about'
      handle_about_route(request)
    else
      handle_not_found(request)
    end
  end

  def handle_root_route(request)
    body = 'Hello, World!'
    [200, { 'Content-Type' => 'text/html' }, [body]]
  end

  def handle_about_route(request)
    body = 'About page'
    [200, { 'Content-Type' => 'text/html' }, [body]]
  end

  def handle_not_found(request)
    body = '/404 Not Found'
    [404, { 'Content-Type' => 'text/html' }, [body]]
  end
end