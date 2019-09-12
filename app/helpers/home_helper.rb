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

  def ratio amount, total
    ((amount.to_f / total) * 100).round(1)
  end
end
