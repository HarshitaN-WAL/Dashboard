require 'rails_helper'

RSpec.describe RolesController, type: :controller do
  let(:role) {create(:role)}
  let(:user) {create(:user)}
  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe ""
end