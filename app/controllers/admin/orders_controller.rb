class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def index
    @orders = Order.all
    @order_items = OrderItem.all
  end

end
