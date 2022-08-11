FactoryBot.define do
  factory :market do
    title { 'Kassulke Inc' }
    description { 'Package / Freight Delivery' }
    phone { '25-178-5119' }
    address { 'Fatimah Avenue' }

    after :create do |market|
      market.categories << build(:category)
    end
  end
end
