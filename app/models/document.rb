class Document < ApplicationRecord
  belongs_to :project
  belongs_to :user, foreign_key: 'creator'
  validates :title, presence: true
  validates :cloudinary_uri, presence: true
end
