class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        sum = 0.0;
        ratings.each{ |rating| sum += rating.score}
        return sum/(ratings.count)
    end
end
