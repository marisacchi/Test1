class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :listing_type
      t.string :experience_type
      t.integer :accommodate
      t.integer :expert_level
      t.integer :fitness_level
      t.string :listing_name
      t.text :summary
      t.string :street
      t.string :suburb
      t.string :city
      t.string :state
      t.string :post_code
      t.string :country
      t.boolean :is_car
      t.boolean :is_mtb
      t.boolean :is_snb
      t.boolean :is_ski
      t.boolean :is_surf
      t.boolean :is_kayak
      t.boolean :is_golf
      t.boolean :is_paddle
      t.boolean :is_fitness
      t.boolean :is_yoga
      t.boolean :is_snorkel
      t.boolean :active
      t.integer :price
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
