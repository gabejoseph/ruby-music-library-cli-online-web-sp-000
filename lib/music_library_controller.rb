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
  
    # describe "#list_songs" do
    # it "prints all songs in the music library in a numbered list (alphabetized by song name)" do
    #   expect($stdout).to receive(:puts).with("1. Thundercat - For Love I Come - dance")
    #   expect($stdout).to receive(:puts).with("2. Real Estate - Green Aisles - country")
    #   expect($stdout).to receive(:puts).with("3. Real Estate - It's Real - hip-hop")
    #   expect($stdout).to receive(:puts).with("4. Action Bronson - Larry Csonka - indie")
    #   expect($stdout).to receive(:puts).with("5. Jurassic 5 - What's Golden - hip-hop")
  
  def play_song 
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i
    array = Song.all.sort{|a, b| a.name <=> b.name}
    song = array[input-1]
    puts "Playing #{song.name} by #{song.artist.name}"
  end 
  
end 