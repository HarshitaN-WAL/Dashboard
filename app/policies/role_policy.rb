# frozen_string_literal: true

class RolePolicy < ApplicationPolicy
  def index?
    user.top_management? || user.admin?
  end
  def new?
    user.admin?
  end
end
