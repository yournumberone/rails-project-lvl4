class Web::RepositoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @repositories = current_user.repositories
  end

  def show
    @repository = Repository.find(params[:id])
  end

  def new
    @repository = Repository.new
    client = Octokit::Client.new access_token: current_user.token, per_page: 100
    @repos = client.repos
  end

  def create
    @repository = current_user.repositories.new(repository_params)
    if @repository.save
      redirect_to repository_path(@repository), notice: t('.success')
    else
      flash[:alert] = t('.fail')
      render :new
    end
  end

  private

  def repository_params
    client = Octokit::Client.new
    repo = client.repo params[:repository][:repo_id].to_i
    { name: repo.name, link: repo.html_url, repo_id: repo.id, language: repo.language }
  end
end
