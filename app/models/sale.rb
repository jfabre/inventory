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

  [:store, :model].each do |k|
    self.define_singleton_method "by_#{k}" do
      joins(k).group(:name).sum(:quantity_sold)
        .sort_by {|k, v| v }
        .reverse
    end
  end
end
