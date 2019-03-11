# frozen_string_literal: true

class PivotalTrackerJob < ApplicationJob
  queue_as :default

  def perform(projetc_id)
    ProjectService.new.stats(Project.find(projetc_id))
  end
end
