#------------------------------------------------------------------------------
# spec/models/user_spec.rb
#------------------------------------------------------------------------------
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validate fields => ' do
    let(:user) { build(:user) }

    it 'Requires a first and last name' do
      expect(user).to be_valid
      expect(user.first_name).to eq('Fred')
      expect(user.last_name).to eq('Flintstone')
    end

    it 'Requires a first name' do
      expect(build(:user, first_name: "")).to be_invalid
    end

    it 'Rejects when first name is to long' do
      expect(build(:user, first_name: "x" * 129)).to be_invalid
    end

    it 'Requires a last name' do
      expect(build(:user, last_name: "")).to be_invalid
    end

    it 'Rejects when last name is to long' do
      expect(build(:user, last_name: "x" * 129)).to be_invalid
    end
  end

end # end of RSpec.describe User
