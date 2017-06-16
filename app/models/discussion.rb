class Discussion < ApplicationRecord
  belongs_to :project
  has_many :posts
end
