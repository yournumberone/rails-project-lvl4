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
    @repos = Rails.cache.fetch("repository_form_#{current_user.nickname}", expires_in: 1.day) do
      client = ApplicationContainer[:octokit].new access_token: current_user.token
      client.repos.delete_if { |r| Repository.language.values.exclude?(r['language']&.downcase) }
    end
  end

  def create
    @repository = current_user.repositories.new(repository_params)
    if @repository.save
      LoadRepositoryInfoJob.perform_later(@repository.id)
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
    params.require(:repository).permit([:github_id])
  end
end
