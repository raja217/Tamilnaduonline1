class Topic < ActiveRecord::Base
  attr_accessible :name, :order, :picture, :video
  has_many :news
  default_scope :order => 'topics.order'
end
