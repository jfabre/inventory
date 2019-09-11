class Shoe < ApplicationRecord
  belongs_to :model
  belongs_to :store

  validates :model_id, uniqueness: { scope: :store_id } 

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

