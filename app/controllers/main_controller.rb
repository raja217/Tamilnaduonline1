class MainController < ApplicationController
	layout :choose_layout


	def choose_layout
		'main'
	end
	def index
		@topic = Topic.find_by_order(1)
		@topic1 = Topic.find_by_order(2)
		@pictures = News.find(:all, :conditions => ['topics_id=?', @topic],:order=>'updated_at desc')
		@pic = News.find(:all, :conditions => ['topics_id=?', @topic1],:order=>'updated_at desc')
		@vid = Topic.last
		@videos = News.find(:all,:conditions => ['topics_id=?', @vid],:order=>'updated_at asc')
		@topics = Topic.find(:all)
		respond_to do |format|
			format.html
		end
	end
	def mainpage
		@topics = Topic.find(:all,:order=>'created_at desc')
		@topic = Topic.find(1)	
		@pictures = News.find(:all, :order=>'updated_at desc', :conditions => ['topics_id=?',@topic])	
	end

	def all
		@topic = Topic.find_by_id(params[:id])
		@pics= News.find(:all, :conditions => ['topics_id=?', @topic],:order=>'updated_at desc')
		@pictures = News.paginate(:page => params[:page], :per_page => 3, :conditions => ['topics_id=?', @topic],:order=>'updated_at desc')
	end
	def news
		@topic = Topic.find_by_id(params[:id])
		@pictures = News.find(:all, :conditions => ['topics_id=?', @topic])	
		respond_to do |format|
      		format.js {render "news", :locals => {:id => @topic}}
    	end
	end
	def content
		#@topic = Topic.find_by_id(params[:id])
		@news = News.find_by_id(params[:id])
		
	end
end
