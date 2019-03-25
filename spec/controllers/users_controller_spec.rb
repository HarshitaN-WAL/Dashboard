# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # render_views

  # let(:user) {create(:user)}
  let!(:user) { create(:user, :with_avatar) }
  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET users' do
    it 'should render index page' do
      get :index
      if user.rolename == 'Top Management'
        expect(response).to render_template(:index)
      else
        expect(response).to redirect_to logout_path
      end
    end
  end

  describe 'NEW user' do
    it 'should create a new user instance' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'Create user' do
    it 'should create a user' do
      role = create(:role, rolename: 'Top Management')
      post :create, params: { user: attributes_for(:user, role_id: role.id)} 
      user = User.last
      expect(response).to redirect_to user_path(user)
    end
  end

  describe 'GET users#show' do
    it 'should render the show page' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET users#edit' do
    it 'should get the user' do
      get :edit, params: { id: user.id, user: user }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PATCH #update' do
    it 'should redirect to the users show page after update' do
      patch :update, params: { id: user.id, user: { username: 'qwerty' } }
      user.reload
      expect(user.username).to eql('qwerty')
    end
  end

  describe 'DELETE #delete' do
    it 'should redirect to index page' do
      delete :destroy, params: { id: user.id }
      expect(User.find_by(id: user.id)).to be_nil
    end
  end
end
