FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      sequence(:email) { |n| "admin_#{n}@example.com" }
      role { :admin }
    end
    
    trait :general do
      sequence(:email) { |n| "general_#{n}@example.com" }
      role { :general }
    end
  end
end