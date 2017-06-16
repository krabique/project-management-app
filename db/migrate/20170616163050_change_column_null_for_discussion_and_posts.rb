class ChangeColumnNullForDiscussionAndPosts < ActiveRecord::Migration[5.0]
  def change
    change_column :discussions, :title, :string, null: false, default: "UnknownTitle"
    change_column :discussions, :creator, :integer, null: false, default: 0
    change_column :posts, :body, :text, null: false
    change_column :posts, :creator, :integer, null: false, default: 0
  end
end
