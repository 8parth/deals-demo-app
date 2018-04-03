FactoryBot.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    email { "some#{Random.rand(1..100)}@gmail.com" }    
  end
end
