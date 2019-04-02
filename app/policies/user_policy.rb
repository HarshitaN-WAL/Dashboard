# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.top_management? || user.admin?
  end
  def new?
    user.top_management? || user.admin?
  end
  def destroy?
    user.top_management? || user.admin?
  end

end
