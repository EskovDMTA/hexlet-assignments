# frozen_string_literal: true
require 'bundler/setup'
require 'minitest/autorun'
require 'power_assert'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = []
  end

  def teardown
    @stack = nil
  end

  def test_add_item_to_stack
    @stack << "qwe"
    @stack << "rty"
    assert_equal 2, @stack.length
    assert_equal "qwe", @stack[0]
  end

  def test_delete_item_from_stack
    @stack << "qwe"
    @stack.pop
    assert_equal 0, @stack.length
  end

  def test_clear_stack
    @stack << "qwe"
    @stack << "rty"
    @stack.clear
    assert_equal true, @stack.empty?

  end

  def test_stack_empty?
    assert_equal true, @stack.empty?
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
