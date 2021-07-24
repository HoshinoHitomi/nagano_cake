class Public::CartItemsController < ApplicationController
  def index
    return if session[:cart_item].blank?

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

    @cart_item_total_price = cart_item_total_price(@cart_item)

  end

  def cart_item_total_price(cart_item)
    cart_item.sum { |hash| hash[:sub_total] }
  end


  def create

    if session[:cart_item].blank?

      session[:cart_item] = [ { item_id: params["item_id"], amount: params["amount"].to_i } ]
      return redirect_to cart_items_path

    end

    match = session[:cart_item].select { |cart_item| cart_item["item_id"] == params["item_id"] }

    if match.present?

      match[0]["amount"] += params["amount"].to_i

    else

      session[:cart_item].push( { item_id: params["item_id"], amount: params["amount"].to_i } )

    end

    redirect_to cart_items_path

  end

  def update
    array_index = session[:cart_item].each_index.select {|i| session[:cart_item][i]["item_id"] == params["item_id"] }
    session[:cart_item[array_index[0]]]["amount"] = params["amount"]
    redirect_to cart_items_path
  end

  def destroy
  end

  def destroy_all
  end

end
