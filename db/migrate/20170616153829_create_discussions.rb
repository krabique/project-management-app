class CreateDiscussions < ActiveRecord::Migration[5.0]
  def change
    create_table :discussions do |t|
      t.string :title
      t.text :body
      t.integer :creator
      t.integer :last_editor
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
