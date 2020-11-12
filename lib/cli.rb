#command line interface 
#interact with user and connect files together

class CLI

    @@suits = ["Major Arcana", "Cups", "Pentacles", "Swords", "Wands"]

    def self.start
        Art.welcome 
        main_menu_display
    end

    def self.exit_program
        Art.ouija 
        exit!
    end

    def self.card_lookup_by_type #view_cards
        display_suits_menu
        mini_menu
        input = gets.chomp 
        if input.upcase == "E" 
            exit_program 
        elsif input.upcase == "M"
            main_menu_display
        elsif input == "1"
            major_arcana 
        elsif input == "2" || input == "3" || input == "4" || input == "5"
            minor_arcana(input)
        else
            puts "Invalid"
            card_lookup_by_type
        end
    end

    def self.major_arcana 
        major_array = []
        major_array = TarotCards.find_by_type("major")
        card_names = []
        major_array.each {|card| card_names << card.name}
        card_names.each_with_index {|name, index| puts "  #{index+1}. #{name}"}
        mini_menu
        input = gets.chomp
        if input.upcase == "M"
            main_menu_display
        elsif input.upcase == "E"
            exit_program
        elsif input.count("a-zA-Z") > 0
            puts "Invalid"
            major_arcana
        elsif  input.to_i <= major_array.length 
            index = input_to_index(input)
            card_display(major_array, index)
            puts "------------------"
            puts "  B. Back to Major Arcana"
            mini_menu
            new_input = gets.chomp
            if new_input.upcase == "B"
                major_arcana
            elsif new_input.upcase == "M"
                main_menu_display
            elsif new_input.upcase == "E"
                exit_program
            else
                puts "Invalid"
                major_arcana
            end
        else
            puts "Invalid"
            major_arcana
        end
    end

    def self.minor_arcana(input)
        index = input_to_index(input)
        suit_array = []
        suit_array = TarotCards.find_by_suit(suits[index].downcase)
        card_names = []
        suit_array.each {|card| card_names << card.name}
        card_names.each_with_index {|name, index| puts "  #{index+1}. #{name}"}
        mini_menu
        new_input = gets.chomp 
        if new_input.upcase == "M"
            main_menu_display
        elsif new_input.upcase == "E"
            exit_program  
        elsif new_input.to_i > card_names.length
            puts "Invalid"
            card_lookup_by_type
        # elsif input.count("a-zA-Z") > 0
        #     puts "Invalid"
        #     card_lookup_by_type
        else
            new_index = input_to_index(new_input)
            card_display(suit_array, new_index)
            puts "------------------"
            puts "  B. Back to #{suits[index]}"
            puts "  S. New search"
            mini_menu
            new_input = gets.chomp
            if new_input.upcase == "M"
                main_menu_display
            elsif new_input.upcase == "E" 
                exit_program
            elsif new_input.upcase == "S"
                card_lookup_by_type
            elsif new_input.upcase == "B"
                minor_arcana(index + 1)
            else
                puts "Not valid"
                card_lookup_by_type
            end
        end
    end

    def self.search_for_cards
        puts "  Enter card name or 'MENU' to return to Main Menu."
        input = gets.chomp 
        if input.upcase == "MENU"
            main_menu_display
        end
        search_array = []
        search_array = TarotCards.find_by_name(input.titleize)
        if search_array.length == 1
            search_array.each do |card|
                puts "------------------"
                puts "  Name: #{card.name}"
                puts "  Type: #{card.type}"
                puts "  Suit: #{card.suit}"
                puts "  Meaning: #{card.meaning_up}"
                puts "  Meaning reversed: #{card.meaning_rev}" 
            end
        elsif search_array.length == 0
            puts "------------------"
            puts "None found"
            search_for_cards
        else
            search_array.each_with_index {|card, index| puts "  #{index+1}. #{card.name}"}
            new_input = gets.chomp
            new_index = input_to_index(new_input)
            search_card = []
            search_card << search_array[new_index]
            search_array.each do |card|
                puts "------------------"
                puts "  Name: #{card.name}"
                puts "  Type: #{card.type}"
                puts "  Suit: #{card.suit}"
                puts "  Meaning: #{card.meaning_up}"
                puts "  Meaning reversed: #{card.meaning_rev}" 
            end
        end
        mini_menu
        puts "  N. New Search"
        input = gets.chomp 
        if input.upcase == "M"
            main_menu_display
        elsif input.upcase == "E"
            exit_program 
        elsif input.upcase == "N"
            search_for_cards
        else
            puts "Invaid"
            mini_menu
            if input.upcase == "M"
                main_menu_display
            elsif input.upcase == "E"
                exit_program 
            else
                puts "Invalid"
                main_menu_display
            end
        end
    end

    def self.reading
        puts "------------------"
        puts "  How many cards? (max 10)"
        spread_input = gets.chomp
        num = spread_input.to_i
        if num <= 0 || num > 10
            puts "Invalid"
            reading
        else
            puts "  #{spread_input} card spread"
            puts "------------------"
            reading_array = []
            num.times {reading_array << TarotCards.all.sample}
            reading_array.each do |card|
                puts "  Name: #{card.name}"
                puts "  Type: #{card.type}"
                puts "  Suit: #{card.suit}"
                puts "  Meaning: #{card.meaning_up}"
                puts "  Meaning reversed: #{card.meaning_rev}" 
                puts "------------------"
            end
       end
        mini_menu
        input = gets.chomp
        if input.upcase == "M"
            main_menu_display
        elsif input.upcase == "E"
            exit_program 
        else
            puts "Invalid"
            main_menu
        end
    end

    def self.main_menu_display 
        puts "------------------"
        puts "  1. View Cards by Suit"
        puts "  2. Search for Cards by Name"
        puts "  3. Get a Reading"
        puts "  E. Exit"
        input = gets.chomp
        if input == "1" #view cards
            puts "View Cards by Suit"
            card_lookup_by_type
        elsif input == "2" #search
            puts "Search for Cards by Name"
            search_for_cards
        elsif input == "3" #reading
            puts "Get a Reading"
            reading 
        elsif input.upcase == "E" #exit 
            exit_program
        else
            puts "Invalid"
            main_menu_display
        end
    end

    def self.mini_menu
        puts "------------------"
        puts "  M. Main Menu"
        puts "  E. Exit"
    end

    def self.card_display(array, index)
        puts "------------------"
        puts "  Name: #{array[index].name}"
        puts "  Type: #{array[index].type}"
        puts "  Suit: #{array[index].suit}"
        puts "  Meaning: #{array[index].meaning_up}"
        puts "  Meaning reversed: #{array[index].meaning_rev}"
    end

    def self.invalid 
        puts "Invalid"
        puts "------------------"
    end

    def self.input_to_index(input)
        input.to_i - 1
    end

    def self.suits
        @@suits 
    end

    def self.display_suits_menu 
        CLI.suits.each_with_index {|item, index| puts "  #{index+1}. #{item}"}
    end

end