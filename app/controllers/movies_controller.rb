class MoviesController < ApplicationController
  load_and_authorize_resource
  #before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  #before_action :check_admin, only: [:edit,:update,:destroy]
  
  # GET /movies
  # GET /movies.json
  def index
    #@movies = Movie.all
    @movies = Movie.order(:updated_at).reverse_order.page params[:page]
    #authorize! :read, Movie
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    # @sum = 0
    # @movie = Movie.find(params[:id])
    # @avg = 0
    # 한줄로 평균점수 구하기 @avg = @movie.reviews.collect {|r| r.rating.to_i}.sum / @movie.reviews.count.to_f

    #authorize! :read, Movie

    #puts @rs
    # @rs.each do |r|
    #   @sum = @sum + r.rating.to_i
    # end
    # @avg = @sum / @movie.reviews.count
  end

  # GET /movies/new
  def new
    @movie = Movie.new
    #authorize! :create, Movie
  end

  # GET /movies/1/edit
  def edit
    # if @movie.user.role == 'admin'
    #   unless current_user.email == @movie.user.email
    #     flash[:notice] = "작성자만 수정할 수 있습니다."
    #     redirect_to movie_path(@movie)
    #   end
    # end
    #authorize! :update, Movie
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
    #authorize! :create, Movie
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
    #authorize! :update, Movie
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
    #authorize! :destroy, Movie
  end

  private

    def check_admin
      unless current_user.admin?
        redirect_to root_path
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :desc, :user_id, :image_url)
    end
end
