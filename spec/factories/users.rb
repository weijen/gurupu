# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid { sprintf("%010d", rand(10000000000)) }
    name {Faker::Name.name}
    email {Faker::Internet.safe_email}
  end
end
