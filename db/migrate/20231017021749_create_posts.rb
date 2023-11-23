class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :place
      t.string :shop_name
      t.string :address

      t.timestamps
    end
  end
end
