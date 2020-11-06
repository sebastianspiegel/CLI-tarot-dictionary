#responsible for talking with api

require 'net/http'
require 'open-uri'
require 'json'
require 'awesome_print'


class API

    def self.start
        url = "https://rws-cards-api.herokuapp.com/api/v1/"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        hash = JSON.parse(response)
        binding.pry 
    end

end

# class API

#     def initialize(url)
#         @url = url 
#     end

#     def get_response_body
#         uri = URI.parse(@url)
#         response = Net::HTTP.get_response(uri)
#         response.body
#     end

#     def parse_json
#         programs = JSON.parse(self.get_response_body)
#     end

# end

# get_requester = API.new("https://rws-cards-api.herokuapp.com/api/v1/")
# ap get_requester.parse_json