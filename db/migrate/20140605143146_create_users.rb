class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :email
      t.boolean :admin
      t.boolean :conedit
      t.string :hashed_password
      t.string :password_salt

      t.timestamps
    end
  end
end
