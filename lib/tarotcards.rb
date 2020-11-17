class TarotCard

    @@all = []

    attr_accessor :name, :value, :suit, :type, :meaning_up, :meaning_rev

    def initialize(name, value, suit = "major", type, meaning_up, meaning_rev) 
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

    def self.find_by_suit(suit) 
        self.all.select {|card| card.suit == suit}
    end

    def self.find_by_name(query) 
        self.all.select {|card| card.name.include?(query)}
    end

    def self.find_by_type(type) 
        self.all.select {|card| card.type == type}
    end

    def self.sorted_by_name
        self.all.sort_by {|card| card.name}
    end

end
