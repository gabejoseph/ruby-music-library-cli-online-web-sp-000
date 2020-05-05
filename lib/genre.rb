require 'pry'
require_relative './concerns/findable.rb'


class Genre 
  
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  
  @@all = []
  
  def initialize(name)
    @name = name 
    save
    @songs = []
  end 
  
  def artists 
    artists = songs.map{|x| x.artist}
    artists.uniq
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
