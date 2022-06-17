# frozen_string_literal: true

class Repository::CheckPolicy < ApplicationPolicy
  def show?
    record.repository.user == user
  end

  def create?
    show?
  end
end
