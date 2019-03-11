require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:project) { create(:project) }
  let!(:user) { create(:user, :with_avatar) }
  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET project' do
    it 'should render index page' do

    end
  end

end