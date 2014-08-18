class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.string :order
      t.boolean :video
      t.boolean :picture

      t.timestamps
    end
  end
end
