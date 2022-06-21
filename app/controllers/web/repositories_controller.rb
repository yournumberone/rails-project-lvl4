# frozen_string_literal: true

class Web::RepositoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @repositories = current_user.repositories
  end

  def show
    @repository = Repository.find(params[:id])
    authorize @repository

    @checks = @repository.checks.order(created_at: :desc)
    @check = @repository.checks.build
  end

  def new
    @repository = Repository.new
    client = Octokit::Client.new access_token: current_user.token, per_page: 100
    ids = current_user.repositories.pluck(:github_id)
    @repos = client.repos
    @repos.delete_if { |r| ids.include? r.id }
  end

  def create
    @repository = current_user.repositories.new(repository_params)
    if @repository.save
      client = ApplicationContainer[:add_webhook].new(access_token: current_user.token)
      add_webhook(client, @repository.github_id)
      redirect_to repository_path(@repository), notice: t('.success')
    else
      flash[:alert] = @repository.errors.first.full_message
      redirect_to new_repository_path
    end
  end

  def destroy
    @repository = Repository.find(params[:id])
    authorize @repository

    if @repository.destroy
      redirect_to repositories_path, alert: t('.success')
    else
      redirect_to repositories_path, alert: t('.fail')
    end
  end

  private

  def repository_params
    client = Octokit::Client.new
    repo = client.repo params[:repository][:github_id].to_i
    { name: repo['name'], full_name: repo['full_name'], link: repo['html_url'], github_id: repo['id'],
      language: repo['language'] || repo['parent']['language'] }
  end

  def add_webhook(client, repository_id)
    return if client.hooks(repository_id).any? { |hook| hook.config.url.start_with?(ENV.fetch('BASE_URL')) }

    client.create_hook(repository_id, 'web',
                       { url: "#{ENV.fetch('BASE_URL')}/api/checks", content_type: 'json' },
                       { events: %w[push pull_request], active: true })
  end
end
