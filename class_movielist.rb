class Movielist < Movie
    HEADER = [:url, :name, :year, :country, :date, :genre, 
      :duration, :rating, :producer, :actor]
    def initialize(filename)
    @filename = filename
    @movielist = CSV.read(@filename, col_sep:('|'), headers: HEADER).
      map{ |film| Movie.new(film) }
  end
  def sort_long_films(value)
    @movielist.sort_by(&:duration).reverse.
      first(value).map{ |movie| [movie.name, movie.duration] }
  end
  def filtre_by_genre(genre)
    @genre = genre
    @movielist.sort_by(&:year).find_all{ |film| film.genre.include?(@genre) }.
      map{ |i| [i.name, i.date] } 
  end
  def producers
    @movielist.map(&:producer).uniq.sort_by { |produser| produser.split(' ')[-1] }
  end
  def non_counrty_films(country)
    @country = country
    @movielist.reject{ |film| film.country == @country }.size
  end
  def producer_stat
    @movielist.group_by(&:producer).map{ |producer, list| [producer, list.size] }
  end
  def actor_stat
    @movielist.map(&:actor).flatten.sort_by{ |actor| actor.split(' ').last }.
      reduce(Hash.new(0)) { |sum, i| sum[i] +=1; sum}
  end
  def month_stat
    @movielist.map( &:date ).reject { |month| month == nil }.sort_by { |month| month.to_s[5..7] }.
      group_by { |month| month.strftime("%B") }.map{ |month, list| [month, list.size] }
  end
end