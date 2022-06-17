# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController

  def show
    @check = Repository::Check.find(params[:id])
    authorize @check

    @repository = @check.repository
    case @repository.language
    when 'Ruby'
      @rubocop = JSON.parse @check&.result
    when 'JavaScript'
      @eslint = JSON.parse @check&.result
    end
  end

  def create
    @repository = find_repository
    @check = @repository.checks.new
    authorize @check

    if @check.save
      LintRepositoryJob.perform_later(@check.id)
      redirect_to repository_path(@repository), notice: t('.success')
    else
      redirect_to repository_path(@repository), alert: t('.fail')
    end
  end

  private

  def find_repository
    @repository = Repository.find(params[:repository_id])
  end
end
