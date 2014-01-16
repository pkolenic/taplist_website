namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    User.create!(first_name: "Example",
                 last_name: "User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
                 
    99.times do |n|
      name = Faker::Name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(first_name: name.first_name,
                   last_name: name.last_name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end