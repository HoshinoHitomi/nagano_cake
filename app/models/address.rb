class Address < ApplicationRecord

  belongs_to :customer

  validates :postal_code, presence: true, format: /\A[0-9]+\z/
  validates :address, presence: true
  validates :name, presence: true

  def all_address_info
    '〒' + self.postal_code + ' ' + self.address + ' ' + self.name
  end
end
