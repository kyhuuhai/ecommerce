class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :description
      t.boolean :status, default: true
      t.references :category, foreign_key: true
    end
  end
end
