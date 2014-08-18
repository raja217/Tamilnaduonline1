class User < ActiveRecord::Base
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  
  attr_accessible :admin, :conedit, :email, :firstname, :lastname, :username, :hashed_password, :password_salt, :role, :password, :new_password, :confirm_password
  attr_accessor :password, :role, :new_password, :confirm_password
  validates_length_of     :username, :within => 1..20
  validates_length_of     :password, :within => 4..40, :allow_nil => true
  before_create :before_save
  before_save :create_password
  validates :new_password,  :presence => true, 
                            :length   => { :within => 6..40 }, 
                            :confirmation => true, 
                            :if       => :password
   

  def before_save
    self.password_salt = random_string(8) if self.password_salt == nil
    self.hashed_password = Digest::SHA1.hexdigest(self.password_salt + self.password) unless self.password.nil?
  end
  def random_string(len)
    randstr = ""
    chars = ("0".."9").to_a + ("a".."z").to_a + ("A".."Z").to_a
    len.times { randstr << chars[rand(chars.size - 1)] }
    randstr
  end
  def persisted?
    false
  end
  def rolename
    return "Admin" if self.admin?
    return "Contedit" if self.conedit?
    return nil
  end
  def fullname
    "#{firstname} #{lastname}"
  end

  def self.authenticate?(username, password)
    u = User.find_by_username(username)
    u.hashed_password == Digest::SHA1.hexdigest(u.password_salt + password)
  end
  private
   def create_password
    self.password = self.username + "123"
    if self.new_record?
      self.admin    = 1 if self.role == 'Admin'
      self.conedit  = 1 if self.role == 'Conedit'
    end
  end
end
