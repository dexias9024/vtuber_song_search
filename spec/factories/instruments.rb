FactoryBot.define do
  factory :instrument do
    sequence(:name) { |n| "#{Faker::Music.name}_#{n}" }
  end
end
