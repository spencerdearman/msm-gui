class MoviesController < ApplicationController
  def create
    # params hash looks like this:
    # {"the_title"=>"1", "the_year"=>"2", "the_duration"=>"3", "the_description"=>"4", "the_image"=>"5", "the_director_id"=>"6"}

    m = Movie.new
    m.title = params.fetch("the_title")
    m.year = params.fetch("the_year")
    m.duration = params.fetch("the_duration")
    m.description = params.fetch("the_description")
    m.image = params.fetch("the_image")
    m.director_id = params.fetch("the_director_id")

    m.save

    redirect_to("/movies")

    # Retrieve the user's inputs from params
    # Create a record in the movie table
    # Populate each column with the user input
    # Save

    # Redirect the user back to the /movies URL
  end

  def destroy
    # Get the ID from params
    the_id = params.fetch("an_id")

    # Find the movie record and destroy it
    matching_movies = Movie.where({ :id => the_id })
    the_movie = matching_movies.at(0)
    the_movie.destroy if the_movie

    # Redirect back to the movies index page
    redirect_to("/movies")
  end

  def update
    # Get the movie ID from params
    the_id = params.fetch("the_id")
    
    # Find the existing movie record
    movie = Movie.where({ id: the_id }).at(0)
    
    # Update movie attributes from form inputs with query_ prefix
    movie.title = params.fetch("query_title")
    movie.year = params.fetch("query_year")
    movie.duration = params.fetch("query_duration")
    movie.description = params.fetch("query_description")
    movie.image = params.fetch("query_image")
    movie.director_id = params.fetch("query_director_id")
    
    # Save the updated movie record
    movie.save
    
    # Redirect to the movie's detail page
    redirect_to("/movies/#{movie.id}")
  end


  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
