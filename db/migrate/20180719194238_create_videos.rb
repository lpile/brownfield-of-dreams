# frozen_string_literal: true

# create video migration
class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :video_id
      t.string :thumbnail
    end
  end
end
