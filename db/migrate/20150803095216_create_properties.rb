class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :property, null: false
      t.integer :user_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
