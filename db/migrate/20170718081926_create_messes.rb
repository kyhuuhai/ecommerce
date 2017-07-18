class CreateMesses < ActiveRecord::Migration[5.0]
  def change
    create_table :messes do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.references :conversation, foreign_key: true

      t.timestamps
    end
  end
end
