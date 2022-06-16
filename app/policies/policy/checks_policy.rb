# frozen_string_literal: true

class Repository::CheckPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def index?
    show?
  end

  def create?
    show?
  end
end
