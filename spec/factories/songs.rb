FactoryBot.define do
  factory :song do
    title { Faker::Lorem.sentence }
    video_url { |n| 'https://www.youtube.com/watch?v=#{SecureRandom.hex(10) + n}' }
    cover { 'cover' }
    vtuber { create(:vtuber, name: Faker::Name.unique.name) }
  end
end