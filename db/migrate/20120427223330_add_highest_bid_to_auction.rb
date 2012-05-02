class AddHighestBidToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :highest_bid_id, :integer
  end
end
