class RatingsController < ApplicationController
    
  # GET /ratings
  # GET /ratings.json
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
  end

  def create
    Rating.create params.require(:rating).permit(:score, :beer_id)
    redirect_to ratings_path
  end

end