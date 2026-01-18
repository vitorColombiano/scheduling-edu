class CreateCourseClasses < ActiveRecord::Migration[8.1]
  def change
    create_table :course_classes do |t|
      t.string :uuid
      t.references :professor, null: false, foreign_key: { to_table: :users }
      t.datetime :start_time
      t.datetime :end_time
      t.string :status
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    add_index :course_classes, :uuid, unique: true
  end
end
