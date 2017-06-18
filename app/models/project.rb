class Project < ApplicationRecord
  has_and_belongs_to_many :users, join_table: "users_projects"
  acts_as_taggable
  has_many :documents
  has_many :wikis
  has_many :discussions
  paginates_per 5
  
  validates :title, presence: true
  validates :description, presence: true

  after_save ThinkingSphinx::RealTime.callback_for(:project)
end
