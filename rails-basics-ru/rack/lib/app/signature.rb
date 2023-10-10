# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    coding256 = Digest::SHA2.hexdigest(body.join)
    body.push coding256
    [status, headers, body]
  end
end
