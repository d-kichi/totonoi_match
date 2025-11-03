class CreateSaunas < ActiveRecord::Migration[7.1]
  def change
    create_table :saunas do |t|
      t.string :name
      t.string :location
      t.float :latitude
      t.float :longitude
      t.integer :temperature
      t.integer :water_temp
      t.boolean :has_outdoor_bath
      t.time :open_time
      t.time :close_time
      t.text :description
      t.references :sauna_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
