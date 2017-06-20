class CreateCartDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_details do |t|
      t.integer :quantity, default: 1
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
