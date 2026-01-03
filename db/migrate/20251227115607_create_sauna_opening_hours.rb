class CreateSaunaOpeningHours < ActiveRecord::Migration[7.1]
  def change
    create_table :sauna_opening_hours do |t|
      t.references :sauna, null: false, foreign_key: true
      t.integer :day_of_week
      t.time :opens_at
      t.time :closes_at
      t.boolean :closed

      t.timestamps
    end
  end
end
