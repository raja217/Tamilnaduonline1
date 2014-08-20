class UserController < ApplicationController
	layout :choose_layout
  #before_filter :login_required, :only => [:dashboard]
  #before_filter :only_admin_allowed, :only => [:new,:create]

	def choose_layout
		return 'login' if action_name == 'login' 
		return 'dashboard' if action_name == 'dashboard'
		'application'
	end
	def login
		if request.post? and params[:user]
     	@user = User.new(params[:user])
     	user = User.find_by_username @user.username
     	if user.present? and User.authenticate?(@user.username, @user.password)
     		authenticated_user = user 
     	end
    end
    if authenticated_user.present?
    	successful_user_login(authenticated_user) and return
    end
  end
  def logout
    Rails.cache.delete("user_main_menu#{session[:user_id]}")
    session[:user_id] = nil
    session[:language] = nil
    flash[:notice] = "Logged Out"
    redirect_to root_url and return
    
  end
  def profile
    @current_user = current_user
    @username = @current_user.username if session[:user_id]
    @user = User.find_by_username(@username)
    unless @user.nil?
      
    else
      flash[:notice] = "#{t('flash14')}"
      redirect_to :action => 'dashboard'
    end
    
  end
  def change_password
    @current_user = current_user
    @user = User.find_by_username(@current_user.username)
  end
  def password_update
    @user = User.find_by_id(params[:id])
        if params[:user][:new_password] == params[:user][:confirm_password]
          @user.password = params[:user][:new_password]
          @user.password_salt = random_string(8)
          @user.hashed_password = Digest::SHA1.hexdigest(@user.password_salt + @user.password)
            if @user.update_attributes(params[:user])
              respond_to do |format|
                format.html { redirect_to :controller => 'user', :action => 'dashboard' }
              end
            else
              respond_to do |format|
                format.html { redirect_to :controller => 'user', :action => 'change_password' }
              end
            end
        end
  end
  def edit
    @user = current_user
    if request.post? and @user.update_attributes(params[:user])
      flash[:notice] = "#{t('flash13')}"
      redirect_to :controller => 'user', :action => 'profile', :id => @user.username
    end
  end
    
	def dashboard
    @user = current_user
		respond_to do |format|
      format.html # show.html.erb
    end
	end
  def new
    @user = User.new
    
  end
  def create
    @user = User.new(params[:user])
    @user.password = params[:password]
      if @user.save
        flash[:notice] = "User Created"
        respond_to do |format|
          format.html { redirect_to :controller => 'user', :action => 'dashboard' }
        end
      else
        flash[:notice] = "#{t('flash16')}"
        redirect_to :controller => 'user', :action => 'new'     
      end
  end
	private
  	def successful_user_login(user)
    	session[:user_id] = user.id
    	flash[:notice] = "#{t('welcome')}, #{user.firstname} #{user.lastname}!"
    	redirect_to :controller => 'user', :action => 'dashboard'
  	end
  private
  def random_string(len)
      randstr = ""
      chars = ("0".."9").to_a + ("a".."z").to_a + ("A".."Z").to_a
      len.times { randstr << chars[rand(chars.size - 1)] }
      randstr
    end
end
