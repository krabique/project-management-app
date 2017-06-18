class CreateFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds do |t|
      t.integer :user, null: false, default: 0
      t.string :action, null: false, default: "UnknownAction"
      t.integer :project
      t.text :body

      t.timestamps
    end
  end
end
