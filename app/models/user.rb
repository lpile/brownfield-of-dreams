# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def bookmarked_videos
    videos.joins(:tutorial).order(:id, Tutorial.arel_table[:title])
  end

  def set_confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
  end
end
