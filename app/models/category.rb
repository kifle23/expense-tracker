class Category < ApplicationRecord
  belongs_to :user
  has_many :category_records, dependent: :destroy
  has_many :records, through: :category_records, dependent: :destroy

  validates :name, presence: true
  validates :icon, presence: true
end
