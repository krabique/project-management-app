class Project < ApplicationRecord
  serialize :developers, Array
  serialize :managers, Array
  
  has_and_belongs_to_many :users, join_table: "users_projects"
end
