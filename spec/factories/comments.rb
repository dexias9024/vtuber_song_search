FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentences }
    association :user, factory: :user
    association :song, factory: :song
  end
end