# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.first( :conditions=>{:admin=>true}).blank?

  user = User.create(:username => 'admin',:firstname => 'Admin',:lastname => 'User', :email => 'noreply@cms.com', :admin => 'true')

  user.update_attributes(:admin=>true,:conedit=>false)
  
end