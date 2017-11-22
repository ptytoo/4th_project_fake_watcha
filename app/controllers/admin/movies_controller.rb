class Admin::MoviesController < Admin::ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
    #authorize! :create, Movie
  end

  # GET /movies/1/edit
  def edit

  end

  def create
    Movie.create(movie_params())
    redirect_to admin_movies_path
  end

  def update
    @movie.update(movie_params())
    redirect_to admin_movie_path(@movie)
  end

  def destroy
    @movie.destroy
    redirect_to admin_movies_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :desc, :image_url)
    end
end
