class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :feeds, :user, :user_id
  end
end
