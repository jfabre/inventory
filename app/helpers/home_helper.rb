module HomeHelper
  def low_inventory_class quantity
    if quantity <= 2
      'bg-danger'
		elsif quantity <= 5
      'bg-warning'
		else
			'bg-success'
		end
  end
end
