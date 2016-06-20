require 'JSON'
require 'HTTParty'
require 'sinatra'

set :port, 6001

post '/getWeatherForcast' do

        content_type 'application/json'
                if params.empty?
                halt 400,"please provide the payload"
        end

        city = params[:city]

        if city.nil? or city.empty?
                halt 400,"city cannot be empty"
        end

        country = params[:country]

        if country.nil? or country.empty?
                halt 400,"country cannot be empty"
        end

        q = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text='#{city}, #{country}')"
                begin
                response=HTTParty.get("https://query.yahooapis.com/v1/public/yql", timeout:5, :query => {'format' => 'json', 'q' => "#{q}" })

        rescue => e
                status 500
                return { status: 500 , message: e.message}.to_json
        end

        body = JSON.parse(response.body)

        if body["query"]["results"].nil?
                status 500
                { 'message' => "No data found for city #{city} and country #{country}" }.to_json

        else

                fahreinheit = body["query"]["results"]["channel"]["item"]["forecast"][0]["high"]
                celcius = (fahreinheit.to_i - 32) * 5.0 / 9.0
                {'city' => city, 'country' => country, 'current' => celcius.round(2), 'units' => 'celcius' }.to_json
        end
end        