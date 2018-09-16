class Brewery < ApplicationRecord
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def average_rating
        sum = 0.0;
        ratings.each{ |rating| sum += rating.score}
        return sum/(ratings.count)
    end
    
end
