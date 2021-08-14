class Item < ApplicationRecord

  belongs_to :genre

  has_many :cart_items
  has_many :order_items
  has_many :orders, through: :order_items

  attachment :image

  def add_tax_price
    (self.price*1.08).round
  end

  with_options presence: true do
    validates :name
    validates :image
    validates :introduction
    validates :price
  end
end
