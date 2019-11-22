class User < ApplicationRecord
  belongs_to :subsidiary, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable
  # and :omniauthable
  enum role: %i[user admin]
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
