# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  def index
    @repository = Repository.find(params[:repository_id])
    @checks = @repository.checks
  end

  def show
    @check = Repository::Check.find(params[:id])
    @repository = @check.repository
    if @check.result.present?
      case @repository.language
      when 'Ruby'
        @rubocop = JSON.parse @check.result
      when 'JavaScript'
        @eslint = JSON.parse @check.result
      end
    end
  end

  def update; end

  def create
    @repository = find_repository
    @check = @repository.checks.new
    if @check.save
      LintRepositoryJob.perform_later(@check.id)
      redirect_to repository_path(@repository), notice: t('.success')
    else
      redirect_to repository_path(@repository), alert: t('.fail')
    end
  end

  def destroy
    @check = Repository::Check.find(params[:id])
    if @check.destroy
      Rails.logger.debug '=' * 180
    end
  end

  private

  def find_repository
    @repository = Repository.find(params[:repository_id])
  end
end
