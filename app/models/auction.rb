class Auction < ActiveRecord::Base
  attr_accessible :expiration, :name
  has_many :bids, :dependent => :destroy
  belongs_to :highest_bid, :class_name => 'Bid'
end
