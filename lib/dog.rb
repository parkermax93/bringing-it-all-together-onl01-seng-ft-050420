class Dog 
  
  attr_accessor :id, :name, :breed 
  
  def initialize (id: nil, name:, breed:)
    @id = id 
    @name = name 
    @breed = breed 
  end
  
  def self.create_table 
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS dogs ( 
      id INTEGER PRIMARY KEY,
      name TEXT,
      breed TEXT
      );
    SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.drop_table 
    sql = <<-SQL 
      DROP TABLE IF EXISTS dogs
    SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.create(name:, breed:)
    dog = Dog.new(name: "#{name}", breed: "#{breed}")
    dog.save
  end
  
  def self.new_from_db(array) 
    dog = self.new(id: array[0], name: array[1], breed: array[2])
  end
  
  def save 
    if self.id
       self.update 
     else
       sql = <<-SQL 
        INSERT INTO dogs (name, breed)
        VALUES (?, ?)
       SQL
       
       DB[:conn].execute(sql, self.name, self.breed)
       @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
     end
     self 
  end
  
  def self.find_by_id(id)
    sql = "SELECT * FROM dogs WHERE id = ?"
    result = DB[:conn].execute(sql, id)[0]
    Dog.new(result[0], result[1], result[2])
  end
end