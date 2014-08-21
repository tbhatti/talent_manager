class Address < ActiveRecord::Base
   attr_accessible :industry, :country , :state ,:user_id
   belongs_to :user
end
