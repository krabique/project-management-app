class RemoveManagersAndDevelopersFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :managers, :text
    remove_column :projects, :developers, :text
  end
end
