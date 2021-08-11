class Address < ApplicationRecord

  belongs_to :customer

  validates :postal_code, format: /\A[0-9]+\z/
  validates :address, presence: true
  validates :name, presence: true
end
