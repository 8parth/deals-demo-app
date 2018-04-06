FactoryBot.define do
  factory :deal do
    status :pending
    title 'Winning Deal'
    value 50000
    customer { Faker::Name.name }
    created_by_id 1
    user_id 1
  end
end
