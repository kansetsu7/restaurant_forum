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

  task fake_followship: :environment do
    Followship.destroy_all
    puts "creating fake followship..." 
    User.all.each do |u|
      @users = User.where.not(id: u.id).shuffle
      5.times do
        u.followships.create!(
        following: @users.pop,
        )      
      end     
    end
    puts "now you have #{Followship.count} followship"
  end

  task fake_friendship: :environment do
    Friendship.destroy_all
    puts "creating fake friendship..." 
    User.all.each do |u|
      @users = User.where.not(id: u.id).shuffle
      5.times do
        u.friendships.create!(
        friend: @users.pop,
        confirmed: false,
        )      
      end     
    end
    puts "now you have #{Friendship.count} friendship"
    Rake::Task['dev:chk_friendship'].execute
  end 

  task chk_friendship: :environment do
    if Friendship.all.count == 0
      puts 'Poor you. No friends...'      
      return
    end

    puts "checking friendship..." 
    Friendship.all.each do |f1|
      Friendship.all.each do |f2|
        if f1.user_id == f2.friend_id && f2.user_id == f1.friend_id
          f1.update_attribute(:confirmed, true)
        end
      end
    end
    puts "#{Friendship.where(confirmed: true).count} friendship are confirmed "
  end 


  task test: :environment do
    puts "testing..." 

    ids = Array.new(0)
    @user = User.first
    puts "A==friends 我提出==A"
    @user.friends.each do |fr|
      puts fr.id
    end
    puts "B==inv_friends 我接收==B"
    @user.inverse_friends.each do |fr|
      puts fr.id
    end
    puts "B==need_confirms 需要我確認==B"
    @user.need_confirms.each do |friendship|
      ids.push(friendship.user_id)
      puts friendship.user_id
    end
    puts "B==need_confirms name==B"
    @need_confirmers = @user.inverse_friends.where(id: ids)
    @need_confirmers.each do |fr|
      puts fr.name
    end
    ids = Array.new(0)
    puts "A==waiting_confirms 等待別人確認==A"
    @user.waiting_confirms.each do |friendship|
      ids.push(friendship.friend_id)
      puts friendship.friend_id
    end
    puts ids.inspect
    puts "A==waiting_confirms name==A"
    @waiting_confirmers = User.where(id: ids)
    @waiting_confirmers.each do |fr|
      puts fr.name
    end
  end

  #fake all data
  task fake_all: :environment do
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_restaurant'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_comment'].execute
    Rake::Task['dev:fake_favorite'].execute
    Rake::Task['dev:fake_like'].execute
    Rake::Task['dev:fake_followship'].execute
    Rake::Task['dev:fake_friendship'].execute
  end

end