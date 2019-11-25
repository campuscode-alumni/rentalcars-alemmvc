class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :street, presence: true
  validates :number, presence: true
  validates :neighborhood, presence: true
  validates :city, presence: true
  validates :state, presence: true

  def label
    "#{street},  nº #{number}"
  end
end
