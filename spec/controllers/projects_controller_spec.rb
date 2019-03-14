require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let!(:project) { create(:project) }  
  let(:user) {create(:user)}
  let(:user1) {create(:user)}
  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET projects' do
    it 'should render index page' do
      session[:user_id] = user.id
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'post create project' do
    it 'should render show page after creation' do
      post :create, params: {"project": build(:project).attributes, "user_id": [user.id]}
      project = Project.last
      expect(response).to redirect_to project_path(project)
    end
  end

  describe 'NEW project' do
    it 'should create a new object' do
      get :new
      # allow(PivotalTrackerJob).to receive(:perform_now).and_return({skjds: skjad})
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe 'GET projects#edit' do
    it "should get the project" do
      get :edit, params: { id: project.id, project: project }
      expect(assigns(:project)).to eq(project)
    end
  end

  describe 'PATCH #update' do
    it 'should redirect to the users show page after updation' do
      patch :update, params: { id: project.id, project: { name: 'qwerty'}, user_id: [user.id] }
      project.reload
      expect(project.name).to eql('qwerty')
    end
  end

  describe 'DELETE #delete' do
    it 'should redirect to index page after deletion' do
      delete :destroy, params: { id: project.id }
      expect(Project.find_by(id: project.id)).to be_nil
    end
  end

  describe 'GET projects#show' do
    it 'should render the show page' do
      get :show, params: { id: project.id }
      allow(PivotalTrackerJob).to receive(:perform_now).and_return({unstarted_bugs: 10, closed_bugs: 5, started_bugs: 10, rejected_bugs: 9})
      expect(response).to render_template(:show)
    end
  end

end