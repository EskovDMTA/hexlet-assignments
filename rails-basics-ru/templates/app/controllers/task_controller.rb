class TaskController < ApplicationController

  def index
    @tasks = Task.order(created_at: :desc)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new()
  end

  def update
    @task = Task.find(params[:id])
  end

  def create

  end

  def delete

  end

end
