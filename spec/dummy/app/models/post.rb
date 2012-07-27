class Post < ActiveRecord::Base
  API_FIELDS = [:title, :body].sort

  attr_accessible :api_user_id, :hmac
  attr_accessible *API_FIELDS

  belongs_to :api_user
end
