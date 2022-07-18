class OrdersController < ApplicationController
  before_action :order_params, only: :create
  before_action :load_resources, only: :index

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    return unless @order.save

    current_cart.ordered!
    redirect_to root_path
  end

  private

  def order_params
    params.require('order').permit(:email, :phone, :address).merge(user: current_user, cart: current_cart)
  end

  def load_resources
    @line_items = current_cart.line_items
  end
end
