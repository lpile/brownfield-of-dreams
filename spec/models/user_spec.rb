# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    it 'bookmarked_videos' do
      t1 = create(:tutorial, title: 'How to Tie Your Shoes vol1')
      v1 = create(:video, title: 'The Bunny Ears Technique vol1', tutorial: t1)
      t2 = create(:tutorial, title: 'How to Tie Your Shoes vol2')
      v2 = create(:video, title: 'The Bunny Ears Technique vol2', tutorial: t2)
      t3 = create(:tutorial, title: 'How to Tie Your Shoes vol3')
      v3 = create(:video, title: 'The Bunny Ears Technique vol3', tutorial: t3)
      user = create(:user)

      create(:user_video, user_id: user.id, video_id: v1.id)
      create(:user_video, user_id: user.id, video_id: v3.id)

      results = user.bookmarked_videos

      expect(results.count).to eq(2)
      expect(results[0]).to eq(v1)
      expect(results[1]).to eq(v3)
    end
  end
end
