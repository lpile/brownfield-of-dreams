# frozen_string_literal: true

# TutorialSerializer
class TutorialSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :thumbnail, :videos

  def videos
    object.videos
  end
end
