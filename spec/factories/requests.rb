FactoryBot.define do
  factory :request do
    user
    category { 'Vtuber' }
    name { Faker::Name.unique.name }
    url { "https://www.youtube.com/watch?v=#{Faker::Internet.user_name}" }
    member_name { Faker::Name.unique.name }

    trait :vtuber do
      category { 'Vtuber' }
      url { "https://www.youtube.com/watch?v=lhd67CnArlI" }
    end
    
    trait :song do
      category { '歌' }
      url { "https://www.youtube.com/watch?v=QzdsaXemBWM" }
    end
  end
end