class Project < ApplicationRecord
  has_and_belongs_to_many :users, join_table: "users_projects"
  acts_as_taggable
  has_many :documents
end
