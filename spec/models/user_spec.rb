# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
   it { should belong_to(:role) }
   it { should have_many(:projects)}
   it { should have_many(:project_users)}
   it { should have_many(:messages)}
   it { should validate_presence_of(:username)}
   it { should validate_length_of(:username)}
   it { should allow_value("abcd@gama.com").for(:email)}
   it { should validate_presence_of(:email)}
   # it { should validate_uniqueness_of(:username).case_insensitive}
   # it { should callback(:email_downcase).before(:save) }
   # it { should validate_uniqueness_of(:username).case_insensitive}
   it { should validate_presence_of(:email)}
   it { should have_secure_password }

   it 'should downcase the email' do
    subject = User.new(email: 'Ashu@wal.com')
    subject.send(:email_downcase)
    expect(subject.email).to eq('ashu@wal.com')
   end

   it 'should call email_downcase' do
    subject = User.new(email: 'Ashu@wal.com')
    allow(subject).to_receive(:email_downcase)
    subject.save
   end

end
