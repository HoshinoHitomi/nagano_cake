class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :cart_items, dependent: :destroy
         has_many :addresses, dependent: :destroy
         has_many :orders, dependent: :destroy

  def active_for_authentication?
    super && (self.is_active == true)
  end

  def name
    last_name + first_name
  end

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :first_name_kana, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :postal_code, format: /\A[0-9]+\z/
  validates :address, presence: true
  validates :telephone_number, format:/\A[0-9]+\z/
end
