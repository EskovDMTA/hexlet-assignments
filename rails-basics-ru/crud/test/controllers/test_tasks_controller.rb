# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../app/controllers/tasks_controller'
class TestTasksController < ActionDispatch::IntegrationTest
  def setup
    Task.delete_all
    @task = Task.create(
      name: Faker::Name.name,
      description: Faker::Quotes::Chiquito.sentence,
      status: 0.to_s,
      creator: Faker::Name.unique.name,
      performer: Faker::Name.unique.name,
      completed: 0.even? ? true : false
    )
  end

  test 'test_create new task' do
    @task = Task.new(
      name: Faker::Name.name,
      description: Faker::Quotes::Chiquito.sentence,
      status: 0.to_s,
      creator: Faker::Name.unique.name,
      performer: Faker::Name.unique.name,
      completed: 0.even? ? true : false
    )
    assert_equal(@task.valid?, true)
  end

  test 'test_show task' do
    get task_path(@task)
    assert_response :success
  end

  test 'test_update task' do
    patch task_path(@task), params: { id: @task.id, task: { name: 'Task 5' } }
    @task.reload
    assert_equal 'Task 5', @task.name
  end

  test 'test_delete task' do
    delete task_path(@task)
    assert_equal(0, Task.count)
  end
end