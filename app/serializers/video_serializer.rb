# frozen_string_literal: true

# VideoSerializer
class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :position
end
