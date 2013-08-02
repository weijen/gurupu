# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    sequence(:name){ |n| "團體- #{n}" }
    description {Faker::Lorem.sentences(5).join("\n\n")}
  end
end
