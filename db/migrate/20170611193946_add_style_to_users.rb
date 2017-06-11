class AddStyleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :dark_style, :boolean, default: false, null: true
  end
end
