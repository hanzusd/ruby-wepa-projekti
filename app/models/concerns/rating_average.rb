module RatingAverage
    extend ActiveSupport::Concern

    def average_rating
        sum = 0.0;
        ratings.each{ |rating| sum += rating.score}
        return sum/(ratings.count)
    end
    
end