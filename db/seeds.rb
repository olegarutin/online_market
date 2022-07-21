10.times do
  Market.create(title: Faker::Company.name, description: Faker::Company.industry, phone: Faker::Company.duns_number, address: Faker::Address.street_name)
  Category.create(title: Faker::Commerce.department)
  Product.create(title: Faker::Food.fruits, description: Faker::Food.description, price: Faker::Commerce.price, image: 'https://images.unsplash.com/photo-1509223197845-458d87318791')
end

Market.all.each { |market| market.categories << Category.all }
Category.all.each { |category| category.products << Product.all }
