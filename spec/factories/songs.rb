FactoryBot.define do
  sequence :video_url do |n|
    "https://www.youtube.com/watch?v=#{SecureRandom.hex(10)}_#{n}"
  end

  factory :song do
    title { Faker::Lorem.sentence }
    video_url { generate(:video_url) }
    cover { 'cover' }
    vtuber { create(:vtuber, name: Faker::Name.unique.name) }
  end
end