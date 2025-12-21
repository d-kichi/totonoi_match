class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    add_index :favorites, [:user_id, :sauna_id], unique: true
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sauna, null: false, foreign_key: true

      t.timestamps
    end
  end
end
