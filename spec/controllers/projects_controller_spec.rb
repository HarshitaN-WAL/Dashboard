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
    it 'should render show page' do
      post :create, params: {"project"=>{"name"=>"Params", "start_date"=>"2019-03-11", "expected_target_date"=>"2019-03-14", "project_token"=>"2199776", "pt_token"=>"db582a94d248f6b17143351774a47847", "quality_token"=>"4a6076ef74c16d09d7cca6dbab264d89dc015eca6dbab264d89dc015eee", "github_slug"=>"HarshitaN-WAL/Dashboard"}, "user_id"=>[user.id]}
      project = Project.last
      expect(response).to redirect_to project_path(project)
    end
  end

  describe 'NEW project' do
    it 'should render show page' do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
  endend

  describe 'GET projects#edit' do
    it "should get the project" do
    
    end
  end


end