class DirectorsController < ApplicationController
  
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    d = Director.new
    d.name = params.fetch("the_name")
    d.dob = params.fetch("the_dob")
    d.bio = params.fetch("the_bio")
    d.image = params.fetch("the_image")
    d.save
  
    redirect_to("/directors")
  end

  def update
    d_id = params.fetch("the_id")
    director = Director.where({ id: d_id }).at(0)
  
    # Ensure these parameter names match the form fields
    director.name = params.fetch("the_name")
    director.dob = params.fetch("the_dob")
    director.bio = params.fetch("the_bio")
    director.image = params.fetch("the_image")
    director.save
  
    redirect_to("/directors/#{director.id}")
  end

  def destroy
    # Get the ID from params
    the_id = params.fetch("an_id")
    # Find and delete the director record
    matching_records = Director.where({ :id => the_id })
    the_director = matching_records.at(0)
    the_director.destroy

    redirect_to("/directors")
  end
end
