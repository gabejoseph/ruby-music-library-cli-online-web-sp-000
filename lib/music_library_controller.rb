require 'pry'
require_relative './concerns/findable.rb'

class MusicLibraryController 
  
  extend Concerns::Findable
  
  attr_accessor :path
  
  def initialize(path = './db/mp3s')
    @path = path
    newobject = MusicImporter.new(path)
    newobject.import
  end 
  
  def call 
    puts 'Welcome to your music library!'
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "What would you like to do?"
    puts "To quit, type 'exit'."
    name = gets.chomp until name == "exit"
  end 
 
  def list_songs 
    Song.all.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end 
  
  def list_artists 
    Artist.all.sort{|a, b| a.name <=> b.name}.each_with_index do |artist, index|
      # binding.pry
      puts "#{index+1}. #{artist.name}"
    end
  end 
  
  def list_genres 
    Genre.all.uniq.sort{|a, b| a.name <=> b.name}.each_with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end 
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    name = gets.chomp
    if Artist.find_by_name(name)
      Artist.find_by_name(name).songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
      end 
    end 
  end
  
  def list_songs_by_genre 
    puts "Please enter the name of a genre:"
    name = gets.chomp 
    if Genre.find_by_name(name)
      Genre.find_by_name(name).songs.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end 
  
  def play_song 
    puts "Which song number would you like to play?"
    name = gets.chomp.to_i
    array = Song.all.sort{|a, b| a.name <=> b.name}
    # .each_with_index do |song, index|
    binding.pry
    puts "Playing #{array.artist.name} by #{}"
  end 
  
end 