class OrdersController < ApplicationController
  before_action :load_resources, only: :index
  before_action :authenticate_user!
  before_action :order_params, only: :create

  def create
    if Order.new(order_params).save
      current_cart.ordered!
      flash.notice = 'Your order was created successfully.'
    end

    redirect_to root_path
  end

  private

  def order_params
    return unless params[:session_id].present?

    @stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])
    return unless current_user?

    session_params(@stripe_session.to_h[:customer_details])
  end

  def load_resources
    @line_items = current_cart.line_items
  end

  def current_user?
    @stripe_session.payment_status == 'paid' || current_user.stripe_customer_id == @stripe_session.customer
  end

  def session_params(session)
    { email: session[:email],
      phone: session[:phone],
      address: session[:address].to_h,
      user: current_user,
      cart: current_cart }
  end
end
