# Category
Category.destroy_all

category_list = [
  {name: "中式料理"},
  {name: "日本料理"},
  {name: "義大利料理"},
  {name: "墨西哥料理"},
  {name: "素食料理"},
  {name: "美式料理"},
  {name: "複合式料理"},
]

category_list.each do |category|
  Category.create(name: category[:name])
end

puts "Category created!"

#Default user: admin and guest
User.create(
  email: "admin@admin.com",
  name: "=BOSS=",
  password: "123456",
  intro: "Who's your daddy!",
  role: "admin"
)
puts "\"Admin\" created!"
