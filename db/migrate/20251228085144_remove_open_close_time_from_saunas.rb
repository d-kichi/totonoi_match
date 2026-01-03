class RemoveOpenCloseTimeFromSaunas < ActiveRecord::Migration[7.1]
  def change
    remove_column :saunas, :open_time, :time
    remove_column :saunas, :close_time, :time
  end
end
