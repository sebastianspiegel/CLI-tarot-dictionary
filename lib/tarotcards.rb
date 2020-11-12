#belongs to a tarotdeck, can create cards and save them to a deck 
# How do we set up a belongs_to relationship?
#     - keep track of all objects being created on initilization 
#     - add an attr_accessor for the thing it belongs to 

class TarotCards

    @@all = []

    attr_accessor :name, :value, :suit, :type, :meaning_up, :meaning_rev

    def initialize(name, value, suit = "major", type, meaning_up, meaning_rev) #should be symbols?
        @name = name
        @value = value
        @suit = suit 
        @type = type 
        @meaning_up = meaning_up
        @meaning_rev = meaning_rev

        @@all << self 
    end

    def self.all
        @@all
    end

    def self.find_by_suit(suit) #major, cups, pentacles, swords, wands ; find or create by suit? and save? 
        self.all.select {|card| card.suit == suit}
    end

    def self.find_by_name(query) #input.include? "wand"
        self.all.select {|card| card.name.include?(query)}
    end

    def self.find_by_type(type) #for the major arcana
        self.all.select {|card| card.type == type}
    end

end
