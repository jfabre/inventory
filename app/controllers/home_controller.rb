class HomeController < ApplicationController
  def index
		@models = Model.all
			.sort_by(&:amount)
			.reverse
		@low_inventory = Shoe.low_inventory
  end

	def inventory
		shoes = Shoe.joins(:store)
			.joins(:model)
			.order(:stores, :model) 
			.includes(:store)
			.includes(:model)

		models, stores = [Model, Store].map do |klass|
			# don't use pluck there's logic for capitalize in the class
			klass.all.map(&:name)
		end

		 data = { 
			stores: stores, 
			models: models, 
			inventory: shoes.map do |s|
				{
					store_name: s.store.name,
					model_name: s.model_name,
					quantity: s.quantity
				}
			end
		}
		render json: data, :'content-type' => :json, status: :ok
	end
end
