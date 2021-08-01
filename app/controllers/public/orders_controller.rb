class Public::OrdersController < ApplicationController
  def new

    if session[:cart_item].blank?
      return redirect_to cart_items_path
    end

    @order = Order.new

    @customer = current_customer

    @addresses = @customer.addresses.page(params[:page])

  end

  def confirm
    @order = Order.new(order_params)

    @cart_items = []

      session[:cart_item].each do |cart_item|
        item = Item.find_by(id: cart_item["item_id"])
        sub_total = item.price * cart_item["amount"].to_i

        next unless item

        @cart_items.push({ item_id: item.id,
                          image_id: item.image_id,
                          name: item.name,
                          price: item.price,
                          amount: cart_item["amount"].to_i,
                          sub_total: sub_total
        })
    end

    @order.payment = params[:order][:payment]

    if params[:order][:address] == "0"

      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.name

    elsif params[:order][:address] == "1"

      @sta = params[:order][:address].to_i
      @order_address = Address.find(@sta)
      @order.postal_code = @order_address.postal_code
      @order.address = @order_address.address
      @order.name = @order_address.name

    else params[:order][:address] = "2"

      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]

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

  private

  def order_params
    params.require(:order).permit(
      :postal_code,
      :address,
      :name,
      :total_payment,
      :payment
      )
  end

end
