class Restaurant
  # class variables
  @@filepath = nil

  # setter method for filepath
  def self.filepath=(path = nil)
    @@filepath = File.join(APP_ROOT, path)
  end

  # instance variables
  attr_accessor :name, :cuisine, :price

  # class methods which start with self
  def self.file_exists?
    # class should know if the restaurant file exists
    if @@filepath && File.exist?(@@filepath)
      return true
    else
      return false

    end
  end

  def self.file_usable?
    return false unless @@filepath && File.exist?(@@filepath) && File.writable?(@@filepath)
    true
  end

  def self.create_file
    # create the restaurant file
    File.open(@@filepath, 'w') unless file_exists?
    file_usable?
  end

  def self.saved_restaurants
    # read the restaurant file
    # return instances of the restaurant
  end

  def self.build_using_questions
    args = {}

    print 'Restaurant name: '
    args[:name] =  gets.chomp.strip

    print 'Cuisine type: '
    args[:cuisine] = gets.chomp.strip

    print 'Average price: '
    args[:price] = gets.chomp.strip

    new(args)
  end

  # instance methods

  def initialize(args = {})
    @name    = args[:name] || ''
    @cuisine = args[:cuisine] || ''
    @price   = args[:price] || ''
  end

  def save
    return false unless Restaurant.file_usable?
    File.open(@@filepath, 'a') do |file|
      # write a tabbed version of the array
      file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
    end
    true
  end
end
