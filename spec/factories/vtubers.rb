FactoryBot.define do
  factory :vtuber do
    channel_name { Faker::Name.unique.name }
    channel_url { "https://www.youtube.com/#{Faker::Internet.user_name}" }
    association :member, factory: :member
    icon { "https://yt3.googleusercontent.com/ytc/APkrFKbvTYI1WVa0WnlLnhU-g-rnIZH_A6zX66i8_1lWsg=s176-c-k-c0x00ffffff-no-rj" }

    after(:create) do |vtuber|
      instruments = create(:instrument)
      vtuber.instruments << instruments
    end
  end
end
