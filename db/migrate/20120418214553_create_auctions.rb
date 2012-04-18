class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :name
      t.datetime :expiration

      t.timestamps
    end
  end
end
