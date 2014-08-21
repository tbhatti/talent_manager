class Comment < ActiveRecord::Base
  attr_accessible :comment, :name,  :user_id
  belongs_to :user
  validates :comment, :presence => {:message => "^ Comment can't be blank"}
end
