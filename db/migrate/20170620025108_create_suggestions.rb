class CreateSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :suggestions do |t|
      t.string :content
      t.boolean :status, default: true
      t.references :user, foreign_key: true
    end
  end
end
