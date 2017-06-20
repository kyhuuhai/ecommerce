class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :content, allow_nil: false
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
