class CreateResults < ActiveRecord::Migration[7.1]
  def change
    create_table :results do |t|
      t.references :sauna_type, null: false, foreign_key: true
      t.string :headline
      t.text :body
      t.text :recommendation_note

      t.timestamps
    end
  end
end
