class ChangeShippingCostOfOrders < ActiveRecord::Migration[5.2]

  def change

    def up
      change_column_default :orders, :shipping_cost, from: nil, to: 800
    end

  end

end