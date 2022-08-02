FactoryBot.define do
  factory :product do
    title { 'Blueberries' }
    description { 'Smoked salmon, poached eggs, diced red onions and Hollandaise sauce on an English muffin. With a side of roasted potatoes.' }
    image { 'https://images.unsplash.com/photo-1509223197845-458d87318791' }
    price { 10 }
  end
end
