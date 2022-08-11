FactoryBot.define do
  factory :category do
    title { 'Toys & Shoes' }

    after :build do |category|
      category.products << build(:product)
    end
  end
end
