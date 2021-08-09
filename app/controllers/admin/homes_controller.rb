class Admin::HomesController < ApplicationController
  def top

    case params[:order]

    when 'customer'

      customer_id = Rails.application.routes.recognize_path(request.referer)[:id]
      @customer = Customer.find(customer_id)
      @orders = @customer.orders.page(params[:page])

    else

    @orders = Order.all

    end

  end
end
