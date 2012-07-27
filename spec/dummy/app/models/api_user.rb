class ApiUser < ActiveRecord::Base
  attr_accessible :secret
  has_many :posts
end
