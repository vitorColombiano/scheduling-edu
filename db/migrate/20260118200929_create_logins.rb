class CreateLogins < ActiveRecord::Migration[8.1]
  def change
    create_table :logins do |t|
      t.string :email
      t.string :password_hash
      t.references :user, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
