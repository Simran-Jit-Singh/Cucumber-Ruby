# Cucumber-Ruby

This project is designed to implement wrapper API over yahoo wather report api https://developer.yahoo.com/weather/.
The wrapper API is written in ruby scripting language. Sinatra is used to start the script and run it as a service on port 6001.

Parameters for post API
{"city":"city_name","country":"country_name"}

response of the API
{"city":city_name", "country":"country_name", "current":"current_temperature","units":"celcius" }

# Cucumber Executor

The project contains cucumber steps to start the service and get the temperatur of the city.

Steps to follow

Ensure you have ruby 2.9.1 or above version installed on your system 

1. Clone: clone the project from  <git clone https://github.com/simranj/Cucumber-Ruby.git>
2. gem install bundler
3. bundle
4. cucumber --tags @getTemperature

The cucumber hooks takes care of starting and stopping the service. 

@Before starts the service on local machine on port 6001.
This is execued before the execution of every scenario.

@After starts the stop the service running on port 6001.
This postdefine hook runs after the end of every scenario.

We can also start the service without cucumber. After resolving all the dependencies, download the file actions.rb and run the command 'ruby actions.rb'.
This will start the service on local machine on port 6001

To fire POST API using Rest Client (POSTMAN), follow these steps
Url: http://127.0.0.1:6001/getWeatherForcast
Body: {"city":"new york","country":"united states"}
Method type: POST
