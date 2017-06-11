class CreateWikis < ActiveRecord::Migration[5.0]
  def change
    create_table :wikis do |t|
      t.string :title, default: "UnknownTitle", null: false
      t.text :body
      t.integer :creator, default: "Unknown", null: false
      t.integer :last_editor, null: true
      t.belongs_to :project, index: true

      t.timestamps
    end
  end
end
