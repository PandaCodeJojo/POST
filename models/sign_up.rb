class Sign_up < ActiveRecord::Base
    has_one :user
    has_one :password
  
  end