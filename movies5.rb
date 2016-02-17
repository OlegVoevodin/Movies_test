puts "введите имя файла" 
filename = gets # получаем имя файла 
filename = filename.chomp 
unless File.exist?(filename) 
  puts "File not found: #{filename}" 
  exit 
end 
require 'csv'
require 'date'

movie_list = Movielist.new(filename)

# первая часть задания. сортировка по длительности фильма 
puts "Часть 1. Самые продолжительные фильмы:"
puts "фильм     продолжительность".rjust(75)
movie_list.sort_long_films(19).each{ |movie, long| puts "#{movie} ==> #{long} мин".rjust(65, '_')}
puts " "

# вторая часть задания сортировка комедий по дате выхода 
puts "Часть 2. Комедии отсортированные по дате выхода:"
puts " "
movie_list.filtre_by_genre('Comedy').each{ |movie, data| puts "#{movie} ===> #{data}"}
puts " "

# третья часть задания. Список режисеров по алфавиту 
puts "Часть 3. Список режисеров по алфавиту:"
puts " "
movie_list.producer.each{ |producer| puts producer }
puts " "

# четвертая часть. колличество фильмов снятых не в США 
puts "Часть 4. Количество фильмов снятых не в США:"
puts movie_list.non_counrty_films('USA')
puts " "

# бонусная часть 1 сколько фильмов снял режисер 
puts "Бонусная часть 1. Сколько фильмов снял режисер"
puts " "
movie_list.producer_stat
puts " "

# бонусная часть 2 в скольких фильмах участвовал актер 
puts "Бонусная часть 2. В скольких фильмах участвовал актер:"
puts " "
movie_list.actor_stat.each { |actor, num|  puts "#{actor.chomp} ==> #{num}" }
puts " "

# использование date
puts "Бонусная часть 3. Статистика по месяцам"
puts " "
movie_list.month_stat.each{ |month, list| puts "#{month} ==> #{list.size}"  }