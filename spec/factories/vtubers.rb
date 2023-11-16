FactoryBot.define do
  factory :vtuber do
    channel_name { Faker::Name.name }
    channel_url { "https://www.youtube.com/#{Faker::Internet.user_name}" }
    association :member, factory: :member

    after(:create) do |vtuber|
      instruments = create(:instrument)
      vtuber.instruments << instruments
    end
  end
end
