class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation
  validates_presence_of :password, :on => :create
end
