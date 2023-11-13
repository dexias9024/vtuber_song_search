FactoryBot.define do
  factory :member do
    sequence(:name) { |n| "#{Faker::Game.name}_#{n}" }
  end
end
