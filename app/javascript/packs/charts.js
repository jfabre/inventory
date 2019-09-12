(function($) {
  "use strict"; // Start of use strict

	$(document).on('turbolinks:load', function() {

		var heatMap = function(stores, models, inventory) {

			var margin = { top: 50, right: 0, bottom: 150, left: 150 };
			var width = 1480 - margin.left - margin.right;
			var	height = 768 - margin.top - margin.bottom

			var gridWidth = Math.floor(width / models.length);
			var gridHeight = Math.floor(height / stores.length);
			var legendElementWidth = gridWidth * 2;
			var colors = ["#ee3e32", "#f68838", "#fbb021", "#1b8a5a", "#1d4877"];

			var svg = d3.select("#chart")
				.append("svg")
				.attr("width", width + margin.left + margin.right)
				.attr("height", height + margin.top + margin.bottom)
				.append("g")
				.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

			var storeLabels = svg.selectAll(".storeLabel")
				.data(stores)
				.enter().append("text")
				.text(function (d) { return d; })
				.attr("x", 0)
				.attr("y", function (d, i) { return i * gridHeight; })
				.style("text-anchor", "end")
				.attr("transform", "translate(-6," + gridHeight / 1.5 + ")")
				.attr("class", "storeLabel mono axis axis-workweek");

			var modelLabels = svg.selectAll(".modelLabel")
				.data(models)
				.enter().append("text")
				.text(function(d) { return d; })
				.attr("x", function(d, i) { return i * gridWidth; })
				.attr("y", 0)
				.style("text-anchor", "middle")
				.attr("transform", "translate(" + gridWidth / 2 + ", -6)")
				.attr("class", "modelLabel mono axis axis-worktime");

			var maxQty = d3.max(inventory, function (d) { return d.quantity; });
			var colorScale = d3.scaleQuantile()
				.domain([0, 5, 10, 20, maxQty])
				.range(colors);

			var cards = svg.selectAll(".card")
				.data(inventory, function(d) { return d; });

			var rect = cards.enter().append("rect")
			rect.attr("x", function(d) { return models.indexOf(d.model_name) * gridWidth; })
				.attr("y", function(d) { return stores.indexOf(d.store_name) * gridHeight; })
				.attr("rx", 4)
				.attr("ry", 4)
				.attr("class", "bordered")
				.attr("width", gridWidth)
				.attr("height", gridHeight)
				.style("fill", colors[0])

			rect.append("svg:title")
				.text(function(d) { return d.quantity; })

			rect.transition().duration(1500)
				.style("fill", function(d) { return colorScale(d.quantity); })

			cards.exit().remove();

			var legend = svg.selectAll(".legend")
				.data(colorScale.quantiles().concat([maxQty]), function(d) { return d; });

			legend = legend.enter().append("g")
			legend.attr("class", "legend");
			legend.append("rect")
					.attr("x", function(d, i) { return legendElementWidth * i; })
					.attr("y", height)
					.attr("width", legendElementWidth)
					.attr("height", gridHeight / 2)
					.style("fill", function(d, i) { return colors[i]; });

			legend.append("text")
				.attr("class", "mono")
				.text(function(d, i) { return "<= " + Math.ceil(d); })
				.attr("x", function(d, i) { return legendElementWidth * i; })
				.attr("y", height + gridHeight);

			legend.exit().remove();
		}

		$.get('inventory.json', function(data, status){
			heatMap(data.stores, data.models, data.inventory);	
		}); 
	})
})(jQuery); // End of use strict
