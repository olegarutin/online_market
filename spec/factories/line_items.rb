FactoryBot.define do
  factory :line_item do
    quantity { 1 }
    cart { build(:cart) }
    product { build(:product) }
  end
end
