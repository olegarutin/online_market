class ApplicationController < ActionController::Base
  helper_method :current_cart

  def current_cart
    Cart.find_or_create_by(user: current_user, status: 'in_progress')
  end
end
