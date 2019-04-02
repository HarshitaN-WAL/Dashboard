require 'rails_helper'

RSpec.describe RolesController, type: :controller do
  let(:role) {create(:role, rolename: 'Admin')}
  let(:user) {create(:user, role_id: role.id)}
  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET roles' do
    it 'should render index page' do
      get :index
      if user.rolename == 'Admin'
        expect(response).to render_template(:index)
      else
        expect(response).to redirect_to logout_path
      end
    end
  end

  describe 'NEW role' do
    it 'should create a new role instance' do
      get :new
      if user.rolename == 'Admin'
      expect(assigns(:role)).to be_a_new(Role)
      else
        expect(response).to redirect_to logout_path
      end
    end
  end

  describe 'Create role' do
    it 'should create a role' do
      # role = create(:role, rolename: 'Top Management')
      post :create, params: { role: attributes_for(:role)}
      role = Role.last
      expect(response).to redirect_to roles_path
    end
  end

  describe 'GET roles#show' do
    it 'should render the show page' do
      get :show, params: { id: role.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET roles#edit' do
    context "when performing edit action" do
      let(:role) {create(:role)}
      it 'should get the role' do
        get :edit, params: { id: role.id, role: role }
        expect(assigns(:role)).to eq(role)
      end
    end
  end

  describe 'PATCH #update' do
    context "when updating" do
      let(:role) {create(:role)}
      it 'should redirect to the roles index after update' do
        patch :update, params: { id: role.id, role: { rolename: 'Front End' } }
        role.reload
        expect(role.rolename).to eql('Front End')
      end
    end
  end

  describe 'DELETE #delete' do
    context "when performing delete action" do 
      let(:role_delete) {create(:role)}
      it 'should redirect to index page' do
        delete :destroy, params: { id: role_delete.id }
        expect(Role.find_by(id: role_delete.id)).to be_nil
      end
    end
  end
end
