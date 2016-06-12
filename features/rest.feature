@restApi 
Feature: start a web service and get the current temperature of cities all over the world

Scenario: start the service and get temperature of a city
Given I start the service
When get temperature for city "berlin" of country "Germany"
Then i stop the service

Scenario: Dont start the service and try to get the temperature
Given the service is down 
And i try to get temperature of "New york", "united states" but expect it to fail 
Then the test fail

Scenario: Pass invalid country and city
Given I start the service
When get temperature by passing invalid city "1" of country "2"
Then the test fail

Scenario 
