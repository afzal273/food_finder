class Restaurant

  # class variables
  @@filepath = nil

  # setter method for filepath
  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT,path)
  end

  # instance variables
  attr_accessor :name, :cusine, :price

  # class methods which start with self
  def self.file_exists?
    # class should know if the restaurant file exists
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false
      
    end
  end

  def self.file_usable?
    return false unless (@@filepath && File.exists?(@@filepath) && File.writable?(@@filepath))
    return true      
  end


  def self.create_file
    #create the restaurant file
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable?
  end

  def self.saved_restaurants
    # read the restaurant file
    # return instances of the restaurant
  end

  # instance methods

  def save
    return false unless Restaurant.file_usable?
    File.open(@@filepath, 'a') do |file|
      # write a tabbed version of the array
      file.puts "#{[@name, @cusine, @price].join("\t")}\n"
    end
    return true
  end


end
