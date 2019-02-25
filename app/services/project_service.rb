class ProjectService

  def stats(pro)
    bug = BugService.new(pro).fetch_count
    { unstarted_bugs: bug[0], closed_bugs: bug[1], started_bugs: bug[2], rejected_bugs: bug[3]}
  end
end