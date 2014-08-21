class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable , :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me,:role, :name ,:comments_attributes
  has_one :address
  mount_uploader :resume, ResumeUploader

  has_many :comments
  accepts_nested_attributes_for :comments, :allow_destroy => true

end
