# frozen_string_literal: true

class RolePolicy < ApplicationPolicy
  def index?
    user.top_management? || user.admin?
  end
end
