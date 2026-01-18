class CreateSchedulings < ActiveRecord::Migration[8.1]
  def change
    create_table :schedulings do |t|
      t.string :uuid, null: false

      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :professor, null: false, foreign_key: { to_table: :users }
      t.references :course_class, null: false, foreign_key: true

      t.datetime :start_time
      t.datetime :end_time
      t.string :status
      t.string :location

      t.timestamps
    end

    add_index :schedulings, :uuid, unique: true
  end
end
