@getTemperature
Feature: start a web service and get the current temperature of cities all over the world

Scenario: Check status of weather forecast service and get the current temperature of a city
Given weather forecast service is up and running on local machine
Then fetch temperature of city "berlin" of country "Germany"
And validate the response for city "berlin" country "Germany"

Scenario: Send invalid data type for city and country name and check the API behaviour
Given weather forecast service is up and running on local machine
When get temperature by passing invalid city "1" of country "2"
Then the weather forecast API should throw error

Scenario: Pass city and country as empty
Given weather forecast service is up and running on local machine
When pass city and country as empty
Then validate API should give error

Scenario: Pass city as valid city and country as empty
Given weather forecast service is up and running on local machine
When pass city as "munich" and country as empty
Then validate API should give error

Scenario: Pass city as empty and country as valid country
Given weather forecast service is up and running on local machine
When pass city as empty and country as "china"
Then validate API should give error

Scenario: Check weather forecast service behaviour with xml content type
Given weather forecast service is up and running on local machine
When send the content type for the weather forecast service as "xml" for city "Vienna" in "Austria"
Then validate that weather forecast service should not allow the content type "xml"

Scenario: Check weather forecast service behaviour with text content type
Given weather forecast service is up and running on local machine
When send the content type for the weather forecast service as "text" for city "Vienna" in "Austria"
Then validate that weather forecast service should not allow the content type "text"

Scenario: Check weather forecast service behaviour with audio content type
Given weather forecast service is up and running on local machine
When send the content type for the weather forecast service as "audio" for city "Vienna" in "Austria"
Then validate that weather forecast service should not allow the content type "audio"

Scenario: Check weather forecast service behaviour with video content type
Given weather forecast service is up and running on local machine
When send the content type for the weather forecast service as "video" for city "Vienna" in "Austria"
Then validate that weather forecast service should not allow the content type "video"

Scenario: Check weather forecast service behaviour with image content type
Given weather forecast service is up and running on local machine
When send the content type for the weather forecast service as "image" for city "Vienna" in "Austria"
Then validate that weather forecast service should not allow the content type "image"

Scenario: Check weather forecast service behaviour with multiplayer content type
Given weather forecast service is up and running on local machine
When send the content type for the weather forecast service as "multiplayer" for city "Vienna" in "Austria"
Then validate that weather forecast service should not allow the content type "multiplayer"

Scenario: Set the request content type as url-encoder which is supported by browser
Given weather forecast service is up and running on local machine
When set request content type to form-url-encoding for city "bern", country "switzerland"
Then validate the response for city "bern" country "switzerland"

Scenario: Check weather forecast service behaviour with different headers
Given weather forecast service is up and running on local machine
When set header of the weather forecast service to Encoding for city "canbbera" in "Australia"
Then validate weather forecast service throw error with header Encoding

Scenario: Check weather forecast service behaviour with different headers
Given weather forecast service is up and running on local machine
When set header of the weather forecast service to charset for city "canbbera" in "Australia"
Then validate weather forecast service throw error with header Encoding

Scenario: perform POST operation on weather forecast service without sending request body
Given weather forecast service is up and running on local machine
Then get temperature for without sending city name and country
And validate API should give error 

Scenario: Perform un supported operation on the API
Given weather forecast service is up and running on local machine
When change the method type to "GET" for city "new york", country "USA" and expect server to throw error
And change the method type to "PUT" for city "new york", country "USA" and expect server to throw error
Then change the method type to "DELETE" for city "new york", country "USA" and expect server to throw error

Scenario: Send a very long name of city and country
Given weather forecast service is up and running on local machine
When send the city name whose length is more then the service can support
Then the weather forecast API should throw error 

Scenario: Pass Invalid String as City and Country and check the API behaviour
Given weather forecast service is up and running on local machine
When pass invalid city as "^&&&&^" and country as "s!!vdl%%%"
Then validate API throw error for unknown city

Scenario: Check case sensitive/ insensitive beahviour of weather forecast service 
Given weather forecast service is up and running on local machine
Then fetch temperature of city "BONN" of country "GERMANY"
And validate the response for city "BONN" country "GERMANY"

Scenario: check the respose time for multiple users 
Given weather forecast service is up and running on local machine
When 15 users use the service for city "bangalore", country "India" immediately one after the another
Then validate the execution time for all the users is not more then 4 seconds