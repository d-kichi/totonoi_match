class AddWebsiteUrlToSaunas < ActiveRecord::Migration[7.1]
  def change
    add_column :saunas, :website_url, :string
  end
end
