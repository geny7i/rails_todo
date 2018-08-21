class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.datetime :due_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
