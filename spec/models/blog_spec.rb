#------------------------------------------------------------------------------
# spec/models/blog_spec.rb
#------------------------------------------------------------------------------
require 'rails_helper'

RSpec.describe Blog, type: :model do
  context 'Validates blog posts => ' do
    let(:user) { create(:user) }
    let(:blog) { build(:blog, user: user)  }

    it 'Requires a title' do
      expect(blog).to be_valid
      expect(build(:blog, title: '')).to be_invalid
    end

    it 'Rejects a title that is too long' do
      expect(build(:blog, user: user, title: 'x' * 124)).to be_valid
      expect(build(:blog, user: user, title: 'x' * 129)).to be_invalid
    end

    it 'Rejects a summary that is too long' do
      expect(build(:blog, user: user, summary: 'x' * 256)).to be_valid
      expect(build(:blog, user: user, summary: 'y' * 257)).to be_invalid
    end

    it 'Requires a posted date' do
      expect(build(:blog, posted: '')).to be_invalid
    end
  end
end
