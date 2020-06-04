class Dog 
  
  attr_accessor :id, :name, :breed 
  
  @@all = [] 
  
  def initialize (id: nil, name:, breed:)
    @id = id 
    @name = name 
    @breed = breed 
    @all << self 
  end
end