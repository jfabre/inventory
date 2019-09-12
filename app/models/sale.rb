class Sale < ApplicationRecord
  belongs_to :store
  belongs_to :model

  validate :quantity_sold_smaller_than_1
  validates_presence_of :store_id, :model_id

  before_validation do
    self.quantity_sold = new_inventory - store.inventory_of(model)
  end
  def quantity_sold_smaller_than_1
    if quantity_sold <= 0
      self.errors[:quantity_sold] << "Can't be smaller than 1"
    end
  end

  def self.by_store
    joins(:store).group(:name).sum(:quantity_sold)
      .sort_by {|k, v| v }
      .reverse
  end

  def self.by_model
    joins(:model).group(:name).sum(:quantity_sold)
      .sort_by {|k, v| v }
      .reverse
  end
end
