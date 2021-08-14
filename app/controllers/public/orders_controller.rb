class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new

    if session[:cart_item].blank?
      return redirect_to cart_items_path
    end

    @order = Order.new

    @customer = current_customer

  end


  def total_price(cart_item)

    cart_item.sum { |price| price[:sub_total] }

  end


  def confirm
    @order = Order.new(order_params)

    @order.customer_id = current_customer.id

    @cart_items = []

      session[:cart_item].each do |cart_item|
        item = Item.find_by(id: cart_item["item_id"])
        sub_total = item.add_tax_price * cart_item["amount"].to_i

        next unless item

        @cart_items.push({item_id: item.id,
                          image_id: item.image_id,
                          name: item.name,
                          price: item.add_tax_price,
                          amount: cart_item["amount"].to_i,
                          sub_total: sub_total
        })
    end

      @order.payment = params[:order][:payment]

      @order.shipping_cost = 800

        @total_price = total_price(@cart_items)

      @order.total_payment = @order.shipping_cost + @total_price


    if params[:order][:address_option] == "0"

      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.name

    elsif params[:order][:address_option] == "1"

      @selection = params[:order][:address]
      @order_address = Address.find(@selection)
      @order.postal_code = @order_address.postal_code
      @order.address = @order_address.address
      @order.name = @order_address.name

    else params[:order][:address_option] = "2"

      @address = Address.new
			@address.customer_id = current_customer.id
			@address.postal_code = params[:order][:new_postal_code]
			@address.address = params[:order][:new_address]
			@address.name = params[:order][:new_name]
			@address.save

      @order.postal_code = params[:order][:new_postal_code]
      @order.address = params[:order][:new_address]
      @order.name = params[:order][:new_name]

      if @order.present?
        render :new
      end

    end

    @order.status = "payment_waiting"


  end

  def create
    order = Order.create!(order_params)

    session[:cart_item].each do |cart_item|
      order.order_items.create(
        item_id: cart_item["item_id"],
        amount: cart_item["amount"],
        price: cart_item["price"],
        making_status: "cannot_making",
        )
    end

    session[:cart_item].clear

    redirect_to thanks_order_path
  end

  def thanks
  end

  def index
    @customer = current_customer
    @orders = @customer.orders.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private

  def order_params
    params.require(:order).permit(
      :customer_id,
      :postal_code,
      :address,
      :name,
      :shipping_cost,
      :total_payment,
      :payment,
      :status
      )
  end

end
