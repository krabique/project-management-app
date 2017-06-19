class Abc < ActiveRecord::Migration[5.0]
  def change
    rename_column :feeds, :project, :project_id   
  end
end
