# frozen_string_literal: true

# BEGIN

# END

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
    repo_url = permitted_params[:link]
    octokit_repo = Octokit::Repository.from_url(repo_url)
    repository_data = JSON.parse(client.repository(octokit_repo))
    # puts "*** Repository Data ***"
    # puts repository_data.inspect
    # puts "*** End of Repository Data ***"
    repository = Repository.create(link: repo_url, description: repository_data['description'])

    if repository.save
      redirect_to root_path
    else
      render new
    end
  end

  def edit
    @repository = Repository.find params[:id]
  end

  def update
    @repository = Repository.find params[:id]

    if @repository.update(permitted_params)
      redirect_to repositories_path, notice: t('success')
    else
      flash[:notice] = t('fail')
      render :edit, status: :unprocessable_entity
    end
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

  def client
    @client ||= Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  end
end
