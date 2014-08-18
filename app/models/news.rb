class News < ActiveRecord::Base
:utf8
WillPaginate.per_page = 3
  attr_accessible :content, :date, :icon_url, :time, :title, :icon_image_data, :icon_image, :link
  attr_accessor :icon_image_data, :icon_image
  YT_LINK_FORMAT = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
 	#validates :link, presence: true, format: YT_LINK_FORMAT

end

