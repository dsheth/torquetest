class Bid < ActiveRecord::Base
  attr_accessible :amount, :status
  belongs_to :auction
  belongs_to :user
end
