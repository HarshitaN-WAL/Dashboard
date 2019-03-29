require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should have_many(:users)}
  it { should have_many(:project_users)}
  it { should have_many(:messages)}
  it { should accept_nested_attributes_for(:repos) }
  # name
  it { should validate_presence_of(:name) }
  # it { should validate_length_of(:name) }
  # it { should validate_uniqueness_of(:name)}
    
end
