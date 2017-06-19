class Post < ApplicationRecord
  belongs_to :discussion
  belongs_to :user, foreign_key: 'creator'
  
  validates :body, presence: true
end
