class Movie < ActiveRecord::Base

  def self.with_ratings(ratings_list)

    rates = ['G', 'PG', 'PG-13', 'R']

    # if ratings_list is nil, retrieve ALL movies
    if ratings_list.nil? || ratings_list.empty?
      return Movie.all
    end

    movies_with_ratings = []

    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    # movies with those ratings
      ratings_list.each do |rating|
        if rates.include?(rating)
          movies_with_ratings += Movie.where(rating: rating) 
        end
      end
    return movies_with_ratings
  end

  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end

end
