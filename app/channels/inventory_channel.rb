class InventoryChannel < ApplicationCable::Channel
  def subscribed
    stream_from "inventory"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
