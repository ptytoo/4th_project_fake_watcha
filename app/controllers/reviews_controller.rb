class ReviewsController < ApplicationController
  def create
    Review.create(
      movie_id: params[:id],
      rating: params[:rating],
      comment: params[:comment]
    )
    @rating_star = params[:rating]
    @comment = params[:comment]
    #redirect_to movie_path(params[:id])
  end
end
