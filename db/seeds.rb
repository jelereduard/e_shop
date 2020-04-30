# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# User

User.create!(
    email: "jelereduard@yahoo.com", 
    password: "foobar", 
    password_confirmation: "foobar", 
    first_name: "Jeler", 
    last_name: "Eduard",
    admin: true)

User.create!(
    email: "nonadmin@yahoo.com", 
    password: "foobar", 
    password_confirmation: "foobar", 
    first_name: "Jeler", 
    last_name: "Alexandru",
    admin: false)

# Categories

Category.create!(
    name: "Burger"
)

Category.create!(
    name: "Soup"
)

Category.create!(
    name: "Pasta"
)

# Products

40.times do |n|
    name=Faker::Food.dish
    description=Faker::Food.description
    price=rand(10.0...99.99).round(2)
    Product.create!(
        name: name,
        price: price,
        description: description,
        category_id: 1,
        image: File.open(File.join(Rails.root, "/app/assets/images/burger.jpeg")),
        stock: Faker::Number.within(range: 0..20)
    )
end

40.times do |n|
    name=Faker::Food.dish
    description=Faker::Food.description
    price=rand(10.0...99.99).round(2)
    Product.create!(
        name: name,
        price: price,
        description: description,
        category_id: 2,
        image: File.open(File.join(Rails.root, "/app/assets/images/soup.jpg")),
        stock: Faker::Number.within(range: 0..20)
    )
end

40.times do |n|
    name=Faker::Food.dish
    description=Faker::Food.description
    price=rand(10.0...99.99).round(2)
    Product.create!(
        name: name,
        price: price,
        description: description,
        category_id: 3,
        image: File.open(File.join(Rails.root, "/app/assets/images/pasta.jpg")),
        stock: Faker::Number.within(range: 0..20)
    )
end