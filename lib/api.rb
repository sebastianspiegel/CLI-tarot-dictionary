
class API

    def self.get_cards
        url = "https://rws-cards-api.herokuapp.com/api/v1/cards/"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        hash = JSON.parse(response)
        array = hash["cards"]
    end

    def self.create_cards
        self.get_cards.each do |card|
            TarotCards.new(card["name"], card["value"], card["suit"], card["type"], card["meaning_up"], card["meaning_rev"])
        end
    end

end
