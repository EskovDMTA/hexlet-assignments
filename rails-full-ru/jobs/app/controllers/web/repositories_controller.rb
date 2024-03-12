# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController

  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
  end

  def show
    @repository = Repository.find params[:id]
  end

  def create
    @repository = Repository.new(permitted_params)
    if @repository.save
      @repository.start_fetching!
      RepositoryLoaderJob.perform_now(@repository.id)
      redirect_to @repository, notice: 'Repository was successfully created.'
    else
      render :new
    end
  end

  def update
    @repository = Repository.find(params[:id])
    @repository.start_fetching!
    RepositoryLoaderJob.perform_later(@repository.id)
    redirect_to @repository, notice: 'Repository was successfully updated.'
  end

  def update_repos
    repositories = Repository.order(updated_at: :asc)
    repositories.each do |repository|
      repository.start_fetching!
      RepositoryLoaderJob.perform_later(repository.id)
    end
    redirect_to repositories_path, notice: 'Repositories are being updated.'
  end


  def destroy
    @repository = Repository.find params[:id]

    if @repository.destroy
      redirect_to repositories_path, notice: t('success')
    else
      redirect_to repositories_path, notice: t('fail')
    end
  end

  private

  def permitted_params
    params.require(:repository).permit(:link)
  end

end
