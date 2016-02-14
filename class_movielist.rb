﻿class Movielist < Movie
  def initialize(filename)
    @filename = filename
    @header = [:url, :name, :year, :country, :date, :genre, :duration, :rating, :producer, :actor]
    @movielist = CSV.read(@filename, col_sep:('|'), write_headers: :true, headers: @header ).map{ |film| Movie.new(film) }
  end
  def sort_long_films
    @movielist.sort_by(&:duration).reverse.first(5).map{ |i| [i.name, i.duration] }
  end
  def sort_by_comedy
    @movielist.sort_by(&:date).find_all{ |film| film.genre.include?('Comedy') }.map{ |i| [i.name, i.date] } 
  end
  def sort_producer
    @movielist.map(&:producer).uniq.sort_by { |i| i.split(' ')[-1] }
  end
  def sort_counrty
    @movielist.reject{ |film| film.country == 'USA' }.size
  end
  def producer_stat
    @movielist.group_by(&:producer).each { |film, list| puts film + "     " + "#{list.size}" }
  end
  def actor_stat
    @movielist.map { |actor| actor.actor.split(',')  }.flatten.sort_by { |i| i.split(' ')[-1] }.reduce(Hash.new(0)) { |sum, i| sum[i] +=1; sum}
  end
  def month_stat
    @movielist.reject { |row| row.date.size == 4 }.each { |row| if row.date.size == 7 then row.date << "-01" end }.
    map { |date| date.date }.sort_by { |i| i[5..7] }.map { |date| Date.strptime(date).strftime("%B") }.group_by { |month| month }
  end
end
