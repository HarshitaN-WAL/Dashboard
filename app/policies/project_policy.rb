class ProjectPolicy < ApplicationPolicy
  def new?
    user.top_management?
  end
end