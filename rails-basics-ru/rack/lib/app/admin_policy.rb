# frozen_string_literal: true

class AdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if request.path.include? '/admin'
      return [403, {}, []]
    end
    @app.call(env)
    # END
  end
end
