FactoryBot.define do
  factory :inquiry do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    content { 'test' }
  end
end