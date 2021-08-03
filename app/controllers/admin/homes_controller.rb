class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    @order_items = OrderItem.all
  end
end
