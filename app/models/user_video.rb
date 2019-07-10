# frozen_string_literal: true

# UserVideo Model is many:many joining table for Users and Videos
class UserVideo < ApplicationRecord
  belongs_to :video, foreign_key: 'video_id'
  belongs_to :user, foreign_key: 'user_id'
end
