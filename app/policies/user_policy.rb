class UserPolicy < ApplicationPolicy
  def index?
    user.top_management?
  end

end