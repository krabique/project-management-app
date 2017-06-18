class Post < ApplicationRecord
  belongs_to :discussion
  
  validates :body, presence: true
end
