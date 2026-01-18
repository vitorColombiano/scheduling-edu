class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :uuid
      t.string :name
      t.text :description
      t.integer :duration_minutes
      t.decimal :price
      t.string :status

      t.timestamps
    end

    add_index :products, :uuid, unique: true
  end
end
