class NewsController < ApplicationController
  require 'rubygems'
  require 'ImageResize'
  before_filter :login_required

  # GET /news
  # GET /news.json
  def index
    @topic = Topic.find_by_id(params[:topic_id])
    @picutes = News.find(:all, :conditions => ['topics_id=?', @topic])
    @news = News.paginate(:page => params[:page], :per_page => 5,:conditions => ['topics_id=?', @topic]) 
    time = Time.now

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = News.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/new
  # GET /news/new.json
  def new
    @news = News.new
    @topic = Topic.find_by_id(params[:topic_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])
    @topic = Topic.find_by_id(params[:topic_id])
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(params[:news])
    @topic = Topic.find_by_id(params[:topic_id])
    @news.topics_id = @topic.id
    respond_to do |format|
      if @news.save
        icon_io = @news.icon_image
          if icon_io.present?
          upload_icon(icon_io)
        end
        flash[:notice] = "News Added Successfully"
        format.html { redirect_to topic_news_index_path(@topic)}
        format.json { render json: @news, status: :created, location: @news }
      else
        format.html { redirect_to new_topic_news_path(@topic) }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.json
  def update
    @news = News.find(params[:id])
    @topic = Topic.find_by_id(params[:topic_id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        icon_io = @news.icon_image 
          if icon_io.present?
          upload_icon(icon_io)
          
        end
        flash[:notice] = 'News was successfully updated.'
        format.html { redirect_to topic_news_index_path(@topic) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @topic = Topic.find_by_id([params[:topic_id]])
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      flash[:notice] = "Deleted Successfully"
      format.html { redirect_to topic_news_index_path(@topic) }
      format.json { head :no_content }
    end
  end
  def select_topic
    @topics = Topic.find(:all)
    
  end
   private  
   def upload_icon(icon_image_io)           
      # upload to the exact location account id and extension
      extension = File.extname(icon_image_io.original_filename)
 
      icon_url = "/uploads/"+@news.id.to_s + extension
 
      # open in binary mode
      File.open("public"+icon_url,'wb') do |file|
        file.write(icon_image_io.read)
      end
 
      @news.update_attribute(:icon_url, icon_url)
   end

end
