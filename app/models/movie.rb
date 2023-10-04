class Movie < ActiveRecord::Base

  def self.with_ratings(ratings_list)

    # if ratings_list is nil, retrieve ALL movies
    if ratings_list.nil? || ratings_list.empty?
      return Movie.all
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    # movies with those ratings  
    else
      return Movie.where(rating: ratings_list) 
    end
  end


  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end

end
