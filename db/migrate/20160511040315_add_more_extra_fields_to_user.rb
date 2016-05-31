class AddMoreExtraFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :dob, :date
    add_column :users, :street, :string
    add_column :users, :suburb, :string
    add_column :users, :state, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :gender, :string
  end
end
