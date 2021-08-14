class Genre < ApplicationRecord

  has_many :items

  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  validates :name, presence: true, uniqueness: true

end
