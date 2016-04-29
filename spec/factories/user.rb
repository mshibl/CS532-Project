FactoryGirl.define do
  factory :user do
    id 1
    auth_token  Faker::Code.ean
    name Faker::Name.first_name
    screen_name Faker::Internet.user_name
    uid Faker::Company.duns_number
    provider "Twitter"
  end

end
