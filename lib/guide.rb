require 'restaurant'
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
      puts 'Listing ....'
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
end
