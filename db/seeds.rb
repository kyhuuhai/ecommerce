# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.delete_all
Category.create! id: 1, name: "Nokia"
Category.create! id: 2, name: "Samsung"
Category.create! id: 3, name: "Iphone"
Category.create! id: 4, name: "LG"
Category.create! id: 5, name: "Sony"
Category.create! id: 6, name: "BPhone"

Product.delete_all
Product.create! name: "Living room", price: 0.49, category_id: 1
Product.create! name: "Bedroom", price: 0.29, category_id: 1
Product.create! name: "Dining room", price: 1.99, category_id: 2
Product.create! name: "Diningroom", price: 4.99, category_id: 3
Product.create! name: "Product a", price: 4.99, category_id: 4
Product.create! name: "Product b", price: 4.99, category_id: 5
Product.create! name: "Product c", price: 4.99, category_id: 2
Product.create! name: "Product d", price: 4.99, category_id: 3
Product.create! name: "Product 1", price: 4.99, category_id: 4
Product.create! name: "Product 2", price: 4.99, category_id: 6

User.delete_all
User.create! email: "dovuquan@gmail.com", password: "dovuquan", password_confirmation: "dovuquan"
User.create! email: "kyhuuhai@gmail.com", password: "dovuquan", password_confirmation: "dovuquan"

