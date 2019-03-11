# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def new?
    user.top_management?
  end
end
