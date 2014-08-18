authorization do
  role :admin do
    has_permission_on [:news], 
    :to => [
    	:new, 
    	:create, 
    	:edit, 
    	:update, 
    	:destroy
    ]
  end
  