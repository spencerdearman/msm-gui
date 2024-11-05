class AddDirectorIdToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :director_id, :integer
  end
end
