class Model < ApplicationRecord
  has_many :shoes
  has_many :sales

  validates :name, uniqueness: true

  def name
    read_attribute(:name).capitalize
  end

  def amount
    Shoe.where(model_id: id)
			.sum(:quantity)
  end

  def ratio
    (amount.to_f / Shoe.total * 100).round(1)
  end

  def self.find_or_create! name
    find_by_name(name) || create!(name: name) 
  end
end
