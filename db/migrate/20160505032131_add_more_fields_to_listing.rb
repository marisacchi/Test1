class AddMoreFieldsToListing < ActiveRecord::Migration
  def change
    add_column :listings, :is_star, :boolean
    add_column :listings, :is_fish, :boolean
    add_column :listings, :is_hik, :boolean
    add_column :listings, :is_trek, :boolean
    add_column :listings, :is_other, :boolean
  end
end
