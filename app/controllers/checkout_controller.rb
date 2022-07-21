class CheckoutController < ApplicationController
  before_action :authenticate_user!, :set_line_items, only: :create

  def create
    @session = Stripe::Checkout::Session.create(
      { customer: current_user.stripe_customer_id,
        success_url: "#{order_create_url}?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: root_url,
        payment_method_types: ['card'],
        line_items: @items,
        phone_number_collection: {
          enabled: true
        },
        'billing_address_collection': 'required',
        mode: 'payment' }
    )

    redirect_to @session.url, allow_other_host: true
  end

  def cancel
    root_url

    flash.notice = 'Something went wrong'
  end

  private

  def set_line_items
    @items = current_cart.line_items.map do |item|
      { amount: (item.product.price * 100).round(0),
        quantity: item.quantity,
        currency: 'usd',
        name: item.product.title,
        images: [item.product.image] }
    end
  end
end
