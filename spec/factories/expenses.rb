# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    name {Faker::Lorem.sentence(3)}
    cost { rand(10000) + 1 }
    date { Date.today - (rand(100) + 1).days}
    group
    user
    tag
  end
end
