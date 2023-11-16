FactoryBot.define do
  factory :song do
    title { Faker::Lorem.sentence }
    video_url { 'https://www.youtube.com/watch?v=#{Faker::Lorem.characters(number: 11)}' }
    cover { 'cover' }
    vtuber { create(:vtuber, name: Faker::Name.unique.name) }
  end
end