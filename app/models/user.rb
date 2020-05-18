class User < ApplicationRecord
  belongs_to :subsidiary, optional: true
  enum role: %i[user admin client]
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
end
