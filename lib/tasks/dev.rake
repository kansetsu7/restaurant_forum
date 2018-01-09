namespace :dev do

  # fake restaurant
  task fake_restaurant: :environment do
    Restaurant.destroy_all
    puts "creating fake restaurants..."
    100.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        image: File.open(File.join(Rails.root, "/public/seed_img/#{rand(0...21)}.jpg")),
      )      
    end
    puts "now you have #{Restaurant.count} restaurants data"
  end

  # fake user
  task fake_user: :environment do
    User.where(role: nil).destroy_all
    puts "creating fake users..."
    for i in 1..20 do
      User.create!(email: "user#{i}@email.com",
        name: "user#{i}",
        password: '000000',
        avatar: File.open(File.join(Rails.root, "/public/avatar/avatar#{rand(1...8)}.jpg")),
      )      
    end
    puts "now you have #{User.count} user data"
  end 

  #fake comment
  task fake_comment: :environment do
    Comment.destroy_all
    puts "creating fake comments..."    
    Restaurant.all.each do |r|
     3.times do
       r.comments.create!(content: FFaker::Lorem.paragraph,
        restaurant_id: r.id,
        user: User.all.sample,
       )      
     end     
    end
    puts "now you have #{Comment.count} user comment"
  end 

  #fake favorite
  task fake_favorite: :environment do
    Favorite.destroy_all
    puts "creating fake favorites..." 
    User.all.each do |u|
     20.times do
       u.favorites.create!(
        restaurant: Restaurant.all.sample,
       )      
     end     
    end
    puts "now you have fake #{Favorite.count} favorited restaurants"
  end 

  #fake like
  task fake_like: :environment do
    Like.destroy_all
    puts "creating fake likes..." 
    User.all.each do |u|
     5.times do
       u.likes.create!(
        restaurant: Restaurant.all.sample,
       )      
     end     
    end
    puts "now you have #{Like.count} liked restaurants"
  end

  task fake_all: :environment do
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_restaurant'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_comment'].execute
    Rake::Task['dev:fake_favorite'].execute
    Rake::Task['dev:fake_like'].execute
  end

end