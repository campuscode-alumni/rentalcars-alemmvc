class Addon < ApplicationRecord
  has_one_attached :photo

  validates :name, :description, presence: true
  validates :photo, attached: true, content_type: ['image/png', 'image/jpg',
                                                   'image/jpeg']
end
