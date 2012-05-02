class AddPlacedTimeToBid < ActiveRecord::Migration
  def change
    add_column :bids, :placed_time, :timestamp
  end
end
