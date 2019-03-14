# frozen_string_literal: true

class ProjectService
  def stats(pro)
    bug = BugService.new(pro).fetch_count
    { unstarted_bugs: bug[:unstarted_bugs], closed_bugs: bug[:closed_bugs], started_bugs: bug[:started_bugs], rejected_bugs: bug[:rejected_bugs] }
  end

  def code_quality(project)
    response = CodeClimateService.new(token: project.quality_token, github_slug: project.github_slug.downcase).fetch_repo
    maintainability_url = JSON.parse(response.body)["data"][0]["links"]["maintainability_badge"]
  end
end
