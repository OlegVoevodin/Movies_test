class Movie
  attr_reader :url, :name, :year, :country, :date, :genre, :duration, :rating, :producer, :actor
  def initialize(row_movie)
    @url = row_movie[0]
    @name = row_movie[1]
    @year = row_movie[2]
    @country = row_movie[3]
    @date = row_movie[4]
    @genre = row_movie[5].to_s
    @duration = row_movie[6].to_i
    @rating = row_movie[7]
    @producer = row_movie[8]
    @actor = row_movie[9].chop.split(',')
    if @date.size == 4 then @date = nil 
      elsif @date.size == 7 then @date = Date.strptime(@date, '%Y-%m')
      else @date = Date.strptime(@date, '%Y-%m-%d')
    end 
  end
end