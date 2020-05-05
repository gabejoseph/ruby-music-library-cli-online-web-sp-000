require 'pry'
class MusicImporter 
  
  attr_accessor :path
  
  @@all = []
  
  def initialize(path)
    @path = path
    @@all << self 
  end 
  
  def files 
    Dir.entries(@path).select {|item| item.size > 3}  
  end
  
  def import 
    files.each{|x| Song.create_from_filename(x)}
  end 
  
  
end 

