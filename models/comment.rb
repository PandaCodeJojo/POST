class Comment < ActiveRecord::Base
    has_one :User
    has_one :post
  
  end