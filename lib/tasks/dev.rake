namespace :dev do

  # fake restaurant
  task fake_restaurant: :environment do
    Restaurant.destroy_all
    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        image: File.open(File.join(Rails.root, "/public/seed_img/#{rand(0...21)}.jpg")),
      )      
    end
    puts "have created fake restaurant"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  # fake user
  task fake_user: :environment do
   User.where(role: nil).destroy_all
   20.times do
     User.create!(email: FFaker::Internet.email,
      password: '000000',
     )      
   end
   puts "have created fake user"
   puts "now you have #{User.count} user data"
  end 

  #fake comment
  task fake_comment: :environment do
   Comment.destroy_all
   Restaurant.all.each do |r|
     3.times do
       r.comments.create!(content: FFaker::Lorem.paragraph,
        restaurant_id: r.id,
        user: User.all.sample,
       )      
     end     
   end
   puts "have created fake comment"
   puts "now you have #{Comment.count} user comment"
  end 

end