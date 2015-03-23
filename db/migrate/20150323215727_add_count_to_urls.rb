class AddCountToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :count, :integer, default: 1
  end
end
