# frozen_string_literal: true

require_relative '../test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get about' do
    get page_path('about')
    assert_response :success
  end
end
