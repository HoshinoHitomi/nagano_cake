class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def order_update
    @order = Order.find(params[:order_id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end

  def making_update
    @order_item = OrderItem.find(params[:order_item_id])
    @order_item.update(order_item_params)
    redirect_to admin_order_path(@order_item)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def order_item_params
    params.require(:order_item).permit(:making_status)
  end
end
