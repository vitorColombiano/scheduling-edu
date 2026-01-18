class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :uuid
      t.string :name
      t.string :phone
      t.string :user_type

      t.timestamps
    end

    add_index :users, :uuid, unique: true
  end
end
