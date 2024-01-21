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

    trait :guest do
      sequence(:email) { |n| "guest_#{n}@example.com" }
      role { :guest }
    end

    trait :old_guest do
      sequence(:email) { |n| "old_guest_#{n}@example.com" }
      role { :guest }
      created_at { Time.zone.parse('2000-01-01') }
    end
  end
end