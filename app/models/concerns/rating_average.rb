module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    sum = 0.0;
    if ratings.empty?
      return sum
    end
      ratings.each{ |rating| sum += rating.score }
      sum / ratings.count
  end
end
