class Order < ApplicationRecord

  belongs_to :customer

  has_many :order_items
  has_many :items, through: :order_items

  enum payment: {
    credit: 0,
    bank: 1
  }

  enum status: {
    payment_waiting: 0,
    confirmation: 1,
    making: 2,
    ready_to_ship: 3,
    sent: 4
  }

end
