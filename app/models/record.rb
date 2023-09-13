class Record < ApplicationRecord
  belongs_to :user
  has_many :category_records, dependent: :destroy
  has_many :category, through: :category_records

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
