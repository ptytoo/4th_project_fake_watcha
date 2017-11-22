class ReviewsController < ApplicationController
  def create
    rate = 0
    unless params[:rating]
      rate = 0
    else
      rate = params[:rating]
    end
    Review.create(
      movie_id: params[:id],
      rating: rate,
      comment: params[:comment]
    )

    redirect_to movie_path(params[:id])
  end
end
