class Discussion < ApplicationRecord
  belongs_to :project
  has_many :posts
  
  validates :title, presence: true
  validates :body, presence: true
end
