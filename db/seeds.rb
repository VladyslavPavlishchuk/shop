# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = %w(Jack Nick Mike Mary)
users.each { |user| User.create(name: user, email:"#{user}mail1@gmail.com") }

categories=%w(Sausages Bread Dessert Alcohol Drinks)
categories.each{ |category| Category.create(name: category, priority: category.length*2) }

products=['Vienna sausage', 'Bratwurst ', 'Salami', 'Hotdogs', 'Black bread', 'Borodinsky', 'Zopf', 'Lavash',
          'Napoleon cake', 'Ice cream', 'Cheesecake', 'Tiramisu', 'Beer', 'Vine', 'Whisky','Tequila',
          'Juice', 'Water','Coca-cola','Smoothy']
products.size.times do |count|
      Product.create(name: products[count], price: products[count].length,
                              description: "This is #{products[count]}.", category_id: count/4)
  #randomtext
end