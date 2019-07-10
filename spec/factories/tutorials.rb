# frozen_string_literal: true

FactoryBot.define do
  factory :tutorial do
    title { Faker::Name.unique.name }
    description { Faker::HitchhikersGuideToTheGalaxy.marvin_quote }
    thumbnail { Faker::LoremPixel.image('460x306') }
    playlist_id { Faker::Crypto.md5 }
    classroom { false }
  end
end
