FactoryGirl.define do
  factory :user do
    first_name            "Patrick"
    last_name             "Kolenic"
    email                 "patrick.kolenic@example.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end