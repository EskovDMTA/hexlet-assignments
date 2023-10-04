# frozen_string_literal: true
# BEGIN
require 'uri'
require 'forwardable'

class Url
  include Comparable
  extend Forwardable

  attr_reader :url

  def_delegators :url, :scheme, :host, :port

  def initialize(url)
    @url = URI.parse url
  end

  def query_params
    URI.decode_www_form(url.query || '').to_h.transform_keys!(&:to_sym)
  end

  def query_param(key, value = nil)
    query_params[key] || value
  end

  def <=>(other)
    to_s <=> other.to_s
  end

  def to_s
    "#{scheme}://#{host}:#{port}#{url.path}?#{sort_query_params}"
  end

  def sort_query_params
    URI.encode_www_form(query_params.sort.to_h)
  end

end
# END