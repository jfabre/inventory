class Shoe < ApplicationRecord
  belongs_to :model
  belongs_to :store

  validates :model_id, uniqueness: { scope: :store_id } 

	def model_name
		model.name
	end

	def model_ratio
		model.ratio
	end
	
	def self.total
		sum(:quantity)
	end

	def quantity_ratio
		(quantity.to_f / 10 * 100).round(1)
	end

  def self.low_inventory(top: 10)
		all.order(:quantity)
			.includes(:model, :store)
			.limit(top)
  end

  def self.update_or_create! store_id: nil, model_id: nil, quantity: nil
    shoe = find_by(store_id: store_id, model_id: model_id)
    if shoe
      shoe.quantity = quantity
      shoe.save!
      shoe
    else
      create!(store_id: store_id, model_id: model_id, quantity: quantity) 
    end
  end
end

