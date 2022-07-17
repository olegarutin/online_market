class LineItemsController < ApplicationController
  before_action :set_line_item, only: :create

  def create
    if @line_item
      @line_item.increment!(:quantity)
    else
      @line_item = LineItem.create(line_item_params)
    end
  end

  private

  def line_item_params
    params.permit(:product_id).merge(quantity: 1, cart: current_cart)
  end

  def set_line_item
    @line_item = current_cart.line_items.find_by(product: params[:product_id])
  end
end
