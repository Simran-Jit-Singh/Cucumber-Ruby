# Cucumber-Ruby

This project is designed to to implement wraper Api over yahoo wather report api https://developer.yahoo.com/weather/.
The wrapper API is written in ruby scripting language. Sinatra is used to start the script and run it as a service on port 6001.

Parameters for post API
{"city":"city_name","country":"country_name"}

response of the API
{"city":city_name", "country":"country_name", "current":"current_temperature","units":"celcius" }

# cucumber executor using ruby

The project also contains cucumber test to start the service and get the temperatur of the city.

Steps to follow to use the project
Ensure you have ruby 2.9.1 or above version installed on your system 

1. Clone: clone the project from  <git clone https://github.com/simranj/Cucumber-Ruby.git>
2. gem install bundler
3. bundle
4. cucumber --tags @restApi

I have Automated 3 test using cucumber

Test 1
Scenario: start the service and get temperature of a city
step 1: start the service 
step 2: pass city name and country name and validate the responses
step 3: stop the service

Test 2
Scenario: dont start the service and try to get the temperature
step 1: keep the service down
step 2: try to get the temperature of some city
step 3: expect failure: Unable to establish TCP connection as service is down

Test 3
Scenario: pass invalid city and country 
step 1: start the service
step 2: try to get temperatur by passing invalid city 
step 3: API should return 500 

We can also start the service without cucumber. After resolving all the dependencies, download the file actions.rb and run the command ruby actions.rb
This will start the service on local machine on port 6001

To fire POST API using Rest Client (POSTMAN), follow these steps
Url: http://127.0.0.1:6001/getWeatherForcast
Body: {"city":"new york","country":"united states"}
Method type: POST
