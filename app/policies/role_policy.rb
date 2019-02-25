class RolePolicy < ApplicationPolicy
  def index?
    user.top_management? or user.admin?
  end

end