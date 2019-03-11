# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :require_user, only: [:home]
  def home; end

  def about; end
end
