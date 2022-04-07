class Asset < ApplicationRecord
  validates :symbol, presence: true, uniqueness: true

  has_many :quotes
  has_one :last_quote, -> { where(quotes: { current: true }) }, class_name: 'Quote'
end
