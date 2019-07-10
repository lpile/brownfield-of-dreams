# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    it 'bookmarked_videos' do
      t1, t2, t3 = create_list(:tutorial, 3)
      v1 = create(:video, tutorial: t1)
      v2 = create(:video, tutorial: t2)
      v3 = create(:video, tutorial: t3)
      user = create(:user)

      create(:user_video, user_id: user.id, video_id: v1.id)
      create(:user_video, user_id: user.id, video_id: v3.id)

      results = user.bookmarked_videos

      expect(results.count).to eq(2)
      expect(results[0]).to eq(v1)
      expect(results[1]).to eq(v3)
    end

    it 'set_confirmation_token' do
      user = create(:user)

      expect(user.confirm_token).to eq(nil)

      user.set_confirmation_token

      expect(user.confirm_token.class).to eq(String)
    end

    it 'validate_email' do
      user = create(:user, confirm_token: '322lkj43kj34')

      expect(user.email_confirmed).to eq(false)
      expect(user.confirm_token).to eq('322lkj43kj34')

      user.validate_email

      expect(user.email_confirmed).to eq(true)
      expect(user.confirm_token).to eq(nil)
    end
  end
end
