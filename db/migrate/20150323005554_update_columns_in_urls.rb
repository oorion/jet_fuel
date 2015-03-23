class UpdateColumnsInUrls < ActiveRecord::Migration
  def change
    remove_column :urls, :url
    remove_column :urls, :shortened_url
    add_column :urls, :original, :string
    add_column :urls, :shortened, :string
  end
end
