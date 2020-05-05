require 'pry'
require_relative './concerns/findable.rb'


class Song 
  
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end 
  
  def genre=(genre)
    @genre = genre
    if !genre.songs.include?(self)
      genre.songs << self
    end
  end 
      
  def self.all 
    @@all 
  end 
  
  def save  
    @@all << self 
  end 
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end 

  def self.destroy_all 
    @@all.clear 
  end 
  
  def self.create(name)
    new = self.new(name)
    new.save
    new  
  end 
  
  def self.new_from_filename(filename)
    array = filename.split(/\ - |.mp3/)
    newsong = self.new(array[1])
    newsong.artist = Artist.find_or_create_by_name(array[0])
    newsong.genre = Genre.find_or_create_by_name(array[2])
    newsong
  end 
  
  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end 
  
end 
