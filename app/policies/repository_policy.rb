# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def destroy?
    show?
  end
end
