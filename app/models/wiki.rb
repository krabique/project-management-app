class Wiki < ApplicationRecord
  belongs_to :project
  belongs_to :user, foreign_key: 'creator'
  
  validates :title, presence: true
  validates :body, presence: true
end
