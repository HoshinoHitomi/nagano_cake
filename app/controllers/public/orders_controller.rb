class Public::OrdersController < ApplicationController
  def new

    if session[:cart_item].blank?
      return redirect_to cart_items_path
    end

    @order = Order.new

    @addresses = Address.all
  end

  def create


    order = current_customer.orders.create!(
      order_date: Time.current
      )

    session[:cart_item].each do |cart_item|
      order.order_items.create(
        item_id: cart_item["item_id"],

        )
    end
  end
end
