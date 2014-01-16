FactoryGirl.define do
  factory :user do
    first_name              "Person"
    sequence(:last_name)    { |n| "#{n}" }
    sequence(:email)        { |n| "person_#{n}@example.com"}
    password                "foobar"
    password_confirmation   "foobar"
    
    factory :admin do
      admin true
    end
  end
end