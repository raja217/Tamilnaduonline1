class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.text :title
      t.text :content
      t.date :date
      t.string :icon_url
      t.time :time

      t.references :topics

      t.timestamps
    end
  end
end
