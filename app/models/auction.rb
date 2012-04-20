class Auction < ActiveRecord::Base
  attr_accessible :expiration, :name
  has_many :bids, :dependent => :destroy
end
