class RenameLocationToAddressInSaunas < ActiveRecord::Migration[7.1]
  def change
    rename_column :saunas, :location, :address
  end
end
