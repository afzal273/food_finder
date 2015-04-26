require 'restaurant'
require 'support/string_extend'
class Guide
  class Config
    @@actions = %w(list find add quit)

    # reader method
    def self.actions
      @@actions
    end
  end

  def initialize(path = nil)
    # locate the restaurant text tile at that path
    # or create a new file
    # exit if create fails
    Restaurant.filepath = path
    if Restaurant.file_usable?
      puts "Found restaurant file.\n"
    elsif Restaurant.create_file
      puts "Created restaurant file.\n"
    else
      puts "Exiting \n\n"
      exit!
    end
  end

  def launch!
    introduction
    # action loop
    # what do you want to do (list, find, add quit)

    result = nil
    until result == :quit
      action = get_action
      # do that action
      result = do_action(action)

    end
    conclusion
  end

  def get_action
    action = nil
    # Keep asking for user input until we get a valid action
    until Guide::Config.actions.include?(action)
      puts 'Actions: ' + Guide::Config.actions.join(', ') if action
      print '> '
      user_response = gets.chomp
      action = user_response.downcase.strip
    end
    action
  end

  def do_action(action)
    case action
    when 'list'
      list
    when 'find'
      puts 'Finding ....'
    when 'add'
      add
    when 'quit'
      return :quit
    else
      puts "\n I don't understand that command. \n"
    end
  end

  def list
    output_action_header("Listing restaurants")
    restaurants = Restaurant.saved_restaurants
    output_restaurant_table(restaurants)
  end

  def add
    puts "\n Add a restaurant \n\n".upcase

    # create a restaurant
    restaurant = Restaurant.build_using_questions

    # save needs to return true or false
    if restaurant.save
      puts "\n Restaurant Added \n\n"
    else
      puts "\n Save Error: Restaurant Not Added \n\n"
    end
  end

  def introduction
    puts "\n\n <<< Welcome to the Food Finder >>> \n\n\n"
    puts "This is an interactive guide to help you find the food you crave \n\n"
  end

  def conclusion
    puts "\n <<< Goodbye and Bon Appetit >>> \n\n\n"
  end
  private
  
  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end
  
  def output_restaurant_table(restaurants=[])
    print " " + "Name".ljust(30)
    print " " + "Cuisine".ljust(20)
    print " " + "Price".rjust(6) + "\n"
    puts "-" * 60
    restaurants.each do |rest|
      line =  " " << rest.name.titleize.ljust(30)
      line << " " + rest.cuisine.titleize.ljust(20)
      line << " " + rest.formatted_price.rjust(6)
      puts line
    end
    puts "No listings found" if restaurants.empty?
    puts "-" * 60
  end
  
end
