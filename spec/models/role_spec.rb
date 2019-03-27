require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "validation" do
    it { should validate_presence_of(:rolename)}
    it { should validate_uniqueness_of(:rolename).case_insensitive}
  end
end
