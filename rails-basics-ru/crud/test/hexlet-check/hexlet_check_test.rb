# frozen_string_literal: true
require 'test_helper'
require_relative '../controllers/test_tasks_controller'

class HexletCheckTest < ActionDispatch::IntegrationTest
  test 'TestTasksController exists and has methods' do
    assert defined? TestTasksController
    test_methods = TestTasksController.new({}).methods.select { |method| method.start_with? 'test_' }
    refute_empty test_methods
  end
end
