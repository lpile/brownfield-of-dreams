# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe 'relationships' do
    it { should have_many :videos }
  end

  describe 'class methods' do
    it '.classroom_content?' do
      tutorial = create(:tutorial, classroom: true)

      expect(tutorial.classroom).to eq(true)
    end
  end
end
