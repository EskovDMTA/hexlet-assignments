# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'
require 'net/http'

class Hacker
  REGISTER_URL = 'https://rails-collective-blog-ru.hexlet.app/users/sign_up'
  URI_REG = URI.parse(REGISTER_URL)

  USER_URL = 'https://rails-collective-blog-ru.hexlet.app/users'
  URI_USER = URI.parse(USER_URL)

  class << self
    def hack(email, password)
      http = Net::HTTP.new(URI_REG.host, URI_REG.port)
      http.use_ssl = URI_REG.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new URI_REG.path
      response = http.request request

      page = Nokogiri::HTML(response.body)
      token = page.at('input[name="authenticity_token"]').attribute('value').to_s
      cookies = response.response['set-cookie'].split('; ')[0]

      request = Net::HTTP::Post.new(URI_USER.path)
      request.body = URI.encode_www_form({
                                           'authenticity_token' => token,
                                           'user[email]' => email,
                                           'user[password]' => password,
                                           'user[password_confirmation]' => password,
                                           'commit' => 'Регистрация'
                                         })
      request['Cookie'] =cookies
      http.request request
    end
  end
end

Hacker.hack("drake4@mail.com", "drakepassword@")
