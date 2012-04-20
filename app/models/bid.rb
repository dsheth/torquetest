class Bid < ActiveRecord::Base
  attr_accessible :amount, :status
  belongs_to :auction, :user
end
