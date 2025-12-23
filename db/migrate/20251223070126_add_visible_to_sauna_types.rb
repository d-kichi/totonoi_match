class AddVisibleToSaunaTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :sauna_types, :visible, :boolean, null: false, default: true
  end
end
