namespace :dev do
  task fake: :environment do
    Restaurant.destroy_all
    # categories_name = ["中式", "日式", "義式", "墨西哥", "素食", "美式", "複合式"]
    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
      )      
    end
    puts "have created fake restaurant"
    puts "now you have #{Restaurant.count} restaurants data"
  end
  task users: :environment do
    User.destroy_all
    User.create!(
      email: "admin@admin.com",
      password: "123456",
      role: "admin"
    )
    User.create!(
      email: "guest@guest.com",
      password: "123456"
    )
  end
end