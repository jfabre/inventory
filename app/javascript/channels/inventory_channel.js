import consumer from "./consumer";
import HeathMap from "../packs/heathmap";

consumer.subscriptions.create("InventoryChannel", {
  connected() {
    this.chart = new HeathMap();
    $.get('inventory.json', (data, status) => {
      this.chart.draw(data.stores, data.models, data.inventory);
      this.chart_loaded = true;
    }); 
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    if(this.chart_loaded){
      this.chart.redraw(data);
    }
  }
});

