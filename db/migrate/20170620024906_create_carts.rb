class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.float :total_price, default: 0.0
      t.boolean :status, default: false
      t.references :user, foreign_key: true
    end
  end
end
