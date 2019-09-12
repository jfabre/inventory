export default class HeathMap {
    constructor() {
      this.margin = { top: 50, right: 0, bottom: 150, left: 160 };
      this.width = 1480 - this.margin.left - this.margin.right;
      this.height = 768 - this.margin.top - this.margin.bottom;
      this.colors = ["#ee3e32", "#f68838", "#fbb021", "#1b8a5a", "#1d4877"];
    }

    draw(stores, models, inventory) {
      this.models = models;
      this.stores = stores;
      this.inventory = inventory;

      this.gridWidth = Math.floor(this.width / this.models.length);
      this.gridHeight = Math.floor(this.height / this.stores.length);

      this.colorScale = d3.scaleQuantile()
        .domain([0, 3, 5, 10, 20, 100])
        .range(this.colors);

      var colorScale = this.colorScale;
      var gridWidth = this.gridWidth;
      var gridHeight = this.gridHeight;
      var legendElementWidth = this.gridWidth * 2;

      var svg = d3.select("#chart")
        .append("svg")
        .attr("width", this.width + this.margin.left + this.margin.right)
        .attr("height", this.height + this.margin.top + this.margin.bottom)
        .append("g")
        .attr("transform", `translate(${this.margin.left},${this.margin.top})`);

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


      var cards = svg.selectAll(".card")
        .data(inventory, function(d) { return d; });

      var rect = cards.enter().append("rect")
      rect
        .attr("x", function(d) { return models.indexOf(d.model_name) * gridWidth; })
        .attr("y", function(d) { return stores.indexOf(d.store_name) * gridHeight; })
        .attr("rx", 4)
        .attr("ry", 4)
        .attr("class", "bordered")
        .attr("width", gridWidth)
        .attr("height", gridHeight)
        .style("fill", this.colors[0])

      rect.append("svg:title")
        .text(function(d) { return d.quantity; })

      rect.transition().duration(1000)
        .style("fill", function(d) { return colorScale(d.quantity); })

      cards.exit().remove();

      var legend = svg.selectAll(".legend")
        .data(colorScale.quantiles().concat([100]), function(d) { return d; });

      legend = legend.enter().append("g")
      var colors = this.colors;
      legend.attr("class", "legend");
      legend.append("rect")
          .attr("x", function(d, i) { return legendElementWidth * i; })
          .attr("y", this.height)
          .attr("width", legendElementWidth)
          .attr("height", gridHeight / 2)
          .style("fill", function(d, i) { return colors[i]; });

      legend.append("text")
        .attr("class", "mono")
        .text(function(d, i) { return Math.floor(d); })
        .attr("x", function(d, i) { return legendElementWidth * i; })
        .attr("y", this.height + gridHeight);

      legend.exit().remove();
    }

    redraw(data) {
      var colorScale = this.colorScale;
      var x = this.models.indexOf(data.model_name) * this.gridWidth;
      var y = this.stores.indexOf(data.store_name) * this.gridHeight;

      var svg = d3.select("#chart");
      var rect = svg.datum(data)
        .select(`rect.bordered[x="${x}"][y="${y}"]`)

      rect.select("title")
        .text(function(d) { return d.quantity; })

      rect.transition().duration(500)
        .style("fill", function(d) { return colorScale(d.quantity); })
    } 
}
