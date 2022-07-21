class User < ApplicationRecord
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create do
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
end
