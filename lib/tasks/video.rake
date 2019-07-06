namespace :video do
  desc "TODO"
  task update_position_of_nil: :environment do
    nil_videos = Video.where(position: nil)
    count_nil_videos = nil_videos.count
    if count_nil_videos > 0
      nil_videos.each do |video|
        tutorials_last_position = Video.where(tutorial_id: video.tutorial_id).where.not(position: nil).order(position: :DESC).limit(1).pluck(:position)[0]
        if tutorials_last_position > 0 
          video.update(position: (tutorials_last_position + 1))
        else
          video.update(position: 1)
        end
      end
      puts "Updated #{count_nil_videos} Video's with nil position values"
    else
      puts "There are no Video's with nil position values"
    end
  end
end
