class LineItemsController < ApplicationController
  before_action :set_line_item, :authenticate_user!

  def create
    if @line_item
      @line_item.increment!(:quantity)
    else
      @line_item = LineItem.create(line_item_params)

      render :create
    end
  end

  def update
    return unless ['increment', 'decrement'].include?(params[:operator])

    case params[:operator]
    when 'increment'
      @line_item.increment!(:quantity)
    when 'decrement'
      return if @line_item.quantity < 2

      @line_item.decrement!(:quantity)
    end
  end

  def destroy
    @line_item.destroy
  end

  private

  def line_item_params
    params.permit(:product_id).merge(quantity: 1, cart: current_cart)
  end

  def set_line_item
    if params[:product_id]
      @line_item = current_cart.line_items.find_by(product: params[:product_id])
    elsif params[:id]
      @line_item = LineItem.find(params[:id])
    end
  end
end
