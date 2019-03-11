# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.top_management?
  end
  def new?
    user.top_management?
  end
end
