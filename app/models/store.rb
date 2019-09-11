class Store < ApplicationRecord
  has_many :shoes
  validates :name, uniqueness: true


  # {"store"=>"ALDO Crossgates Mall", "model"=>"ADERI", "inventory"=>73}
  def self.update! data
    store_name = data["store"][5..-1]
    model_name = data["model"].downcase
    qty = data["inventory"]

    ActiveRecord::Base.transaction do
      store = Store.find_or_create!(store_name)
      model = Model.find_or_create!(model_name)

      Shoe.update_or_create!(store_id: store.id, model_id: model.id, quantity: qty)
    end
  end

  def self.find_or_create! name
    find_by_name(name) || create!(name: name) 
  end
end
