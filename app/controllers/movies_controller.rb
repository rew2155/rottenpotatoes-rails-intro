class MoviesController < ApplicationController

  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

    if params[:sort].blank? && params[:ratings].blank?
      @selected_column = 'title'
      session[:sort] = @selected_column
      @ratings_to_show = Movie.all_ratings
      session[:ratings] = @ratings_to_show
    else
      @selected_column = params[:sort] || session[:sort]
      session[:sort] = @selected_column
      @ratings_to_show = params[:ratings].keys || session[:ratings] || Movie.all_ratings
      session[:ratings] = @ratings_to_show
      #redirect_to movies_path(sort: @selected_column);
      redirect_to movies_path(sort: @selected_column, ratings: Hash[@ratings_to_show.map { |r| [r,1]}]) and return
    end

    @all_ratings = Movie.all_ratings
    sort_by = @selected_column
    @movies = Movie.with_ratings(@ratings_to_show).order(sort_by)
    @column_css_class = {
      "title" => "hilite bg-warning",
      "release_date" => "hilite bg-warning"
    }
  end


=begin
  def index  
      if params[:ratings]
        @ratings_to_show = params[:ratings].keys
        session[:ratings] = params[:ratings]
      else 
      #if params[:ratings] == nil
        @ratings_to_show = Movie.all_ratings
      end
        
      @all_ratings = Movie.all_ratings

      sort_by = params[:sort] || 'title'
      @movies = Movie.with_ratings(@ratings_to_show).order(sort_by)
      @selected_column = sort_by
      @column_css_class = {
        "title" => "hilite bg-warning",
        "release_date" => "hilite bg-warning"
      }
      session[:sort] = @selected_column
  end
=end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
