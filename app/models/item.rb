class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day

  validates :name,           presence: true, length: { maximum: 40 }
  validates :description,    presence: true, length: { maximum: 1000 }
  validates :category_id,    presence: true
  validates :status_id,      presence: true
  validates :shipping_id,    presence: true
  validates :prefecture_id,  presence: true
  validates :shipping_day_id,presence: true 
  validates :price,          presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than: 10_000_000}

end
