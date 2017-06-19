class Discussion < ApplicationRecord
  belongs_to :project
  has_many :posts
  belongs_to :user, foreign_key: 'creator'
  
  validates :title, presence: true
  validates :body, presence: true
end
