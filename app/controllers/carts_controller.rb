class CartsController < ApplicationController
  before_action :authenticate_user!, :set_line_items

  private

  def set_line_items
    @line_items = current_cart.line_items.order(created_at: :desc)
  end
end
