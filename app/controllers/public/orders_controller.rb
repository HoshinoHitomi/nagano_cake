class Public::OrdersController < ApplicationController
  def new

    if session[:cart_item].blank?
      return redirect_to cart_items_path
    end

    @order = Order.new

    @addresses = Address.all

  end

  def confirm
    @cart_item = []

    session[:cart_item].each do |cart_item|

      item = Item.find_by(id: cart_item["item_id"])

      sub_total = item.price * cart_item["amount"].to_i

      next unless item

      @cart_item.push({ item_id: item.id,

                        name: item.name,

                        price: item.price,

                        amount: cart_item["amount"].to_i,

                        sub_total: sub_total

      })
    end
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
