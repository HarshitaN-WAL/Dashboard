class BugService
  attr_accessor :project
  delegate :pt_token, :project_token, to: :project
  def initialize(project)
    self.project = project
  end

  def fetch_count
    @unstarted_bugs = fetch_stories(state: 'unstarted').count
    @closed_bugs = fetch_stories(state: 'accepted').count
    @started_bugs =  fetch_stories(state: 'started').count
    # @total_issues = fetch_client.stories(with_story_type: 'bug').count
    @rejected_bugs = fetch_stories(state: 'rejected').count
    # [@unstarted_bugs, @closed_bugs, @started_bugs, @rejected_bugs]
    { unstarted_bugs: @unstarted_bugs, closed_bugs: @closed_bugs, started_bugs: @started_bugs, rejected_bugs: @rejected_bugs}
  end

  def fetch_client
    client ||= TrackerApi::Client.new(token: pt_token).project(project_token)
  end

  def fetch_stories(state:)
    fetch_client.stories(with_story_type: 'bug', with_state: state)
  end
end