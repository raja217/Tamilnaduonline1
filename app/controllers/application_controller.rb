class ApplicationController < ActionController::Base
  protect_from_forgery

   before_filter :message_user



  def message_user
   	@current_user = current_user
 	end
   def current_user
    User.find(session[:user_id]) unless session[:user_id].nil?
  end

  
  protected
  def login_required
    unless session[:user_id]
      session[:back_url] = request.url
      flash[:notice] = "Login required to access this page"
      redirect_to :controller => 'user', :action => 'login'
    end
  end
	def permission_denied
  	flash[:error] = "Sorry, you are not allowed to access that page."
  	redirect_to root_url
	end
  def only_admin_allowed
    flash[:error] = "Sorry, you are not allowed to access that page."
    
    redirect_to :controller => 'user', :action => 'dashboard' unless current_user.admin?
  end
end
