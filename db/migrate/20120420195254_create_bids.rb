class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :amount, :precision => 15, :scale => 2
      t.string :status

      t.timestamps
    end
  end
end
