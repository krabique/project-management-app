class Document < ApplicationRecord
  belongs_to :project
  validates :title, presence: true
  validates :cloudinary_uri, presence: true
end
