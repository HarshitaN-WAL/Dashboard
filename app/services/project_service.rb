class ProjectService

  def stats(pro)
    bug = BugService.new(pro).fetch_count
    { unstarted_bugs: bug[:unstarted_bugs], closed_bugs: bug[:closed_bugs], started_bugs: bug[:started_bugs], rejected_bugs: bug[:rejected_bugs]}
  end
end