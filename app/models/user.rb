class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 50 }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
end
