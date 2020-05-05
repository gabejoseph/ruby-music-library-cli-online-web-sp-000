require 'pry'
require_relative './concerns/findable.rb'

class Artist 
  
  extend Concerns::Findable
  
  attr_accessor :name, :songs

  @@all = []
  
  def initialize(name)
    @name = name 
    @songs = []
  end 
  
  def add_song(song)
    if !song.artist  
      song.artist = self
    end 
    if !songs.include?(song)
      songs << song
    end 
  end 
  
  def genres 
    genres = songs.map{|x| x.genre}
    genres.uniq
  end 
  
  def self.all 
    @@all 
  end 
  
  def save  
    @@all << self 
  end 
  
  def self.destroy_all 
    @@all.clear 
  end 
  
  def self.create(name)
    new = self.new(name)
    new.save
    new  
  end 
  
end 
  
  
  
  
