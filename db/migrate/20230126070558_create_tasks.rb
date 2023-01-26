class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :task, null: false
      t.boolean :completed, null: false, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
