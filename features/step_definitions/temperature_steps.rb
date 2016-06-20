require 'HTTParty'

Then /^weather forecast service is up and running on local machine$/ do
    begin
        $pid.should_not be_nil
        puts "Service is running with Process Id #{$pid}"

    rescue => ex
        # throw new Exception if the service in not running
        puts "ERROR: WEATHER FORECAST SERVICE IS DOWN #{$pid}. #{ex.class}=#{ex.message}"
        raise
    end
end


When /^pass city and country as empty$/ do
    url="http://127.0.0.1:6001/getWeatherForcast"
    response=HTTParty.post(url, {:body => { "city" => "", "country" => "" },:headers => { 'Content-Type' => 'application/json' }})
    #set the response code for validation
    $responseCode=response.code
end


Then /^validate API should give error$/ do
    $responseCode.should == 400
end


When /^pass city as empty and country as "([^"]*)"$/ do |country|
    url="http://127.0.0.1:6001/getWeatherForcast"
    response=HTTParty.post(url, {:body => { "city" => "", "country" => country },:headers => { 'Content-Type' => 'application/json' }})
    $responseCode=response.code
end


When /^pass city as "([^"]*)" and country as empty$/ do |city|
    url="http://127.0.0.1:6001/getWeatherForcast"
    response=HTTParty.post(url, {:body => { "city" => city, "country" => "" },:headers => { 'Content-Type' => 'application/json' }})
    $responseCode=response.code
end


When /^fetch temperature of city "([^"]*)" of country "([^"]*)"$/ do | city, country|
    url="http://127.0.0.1:6001/getWeatherForcast?city=#{city}&country=#{country}"
    response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/json' }})
    puts "Server Response is: #{response}"
    body = JSON.parse(response.body)
    $responseBody=body
    $responseCode=response.code
end


Then /^validate the response for city "([^"]*)" country "([^"]*)"$/ do |city , country|
    $responseCode.should == 200
    $responseBody.should_not be_nil
    $responseBody["city"].should == city
    $responseBody["country"].should == country
    $responseBody["current"].should_not be_nil
end


When /^get temperature by passing invalid city "([^"]*)" of country "([^"]*)"$/ do |city, country|
    puts "city: #{city}"
    puts "country: #{country}"
    url="http://127.0.0.1:6001/getWeatherForcast?city=#{city}&country=#{country}"
    response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/json' }})
    $responseCode=response.code
end


Then /^the weather forecast API should throw error$/ do
    $responseCode.should == 500
end


When /^send the content type for the weather forecast service as "([^"]*)" for city "([^"]*)" in "([^"]*)"$/ do |headerType, city, country|
    url="http://127.0.0.1:6001/getWeatherForcast"
    case headerType

    when "xml"
        response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/xml' }})
        $responseCode=response.code

    when "text"
        response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/text' }})
        $responseCode=response.code

    when "audio"
        response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/audio' }})
        $responseCode=response.code

    when "image"
        response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/image' }})
        $responseCode=response.code

    when "multipart"
        response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/multipart' }})
        $responseCode=response.code

    when "video"
        response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/video' }})
        $responseCode=response.code

    end
end


When /^validate that weather forecast service should not allow the content type "([^"]*)"$/ do |headerType|
    case headerType

    when "xml"
        $responseCode.should == 400

    when "text"
        $responseCode.should == 400

    when "audio"
        $responseCode.should == 400

    when "image"
        $responseCode.should == 400

    when "multipart"
        $responseCode.should == 400

    when "video"
        $responseCode.should == 400

    end
end


When /^set header of the weather forecast service to Encoding for city "([^"]*)" in "([^"]*)"$/ do | city, country|
    url="http://127.0.0.1:6001/getWeatherForcast?city=#{city}&country=#{country}"
    response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Accept-Encoding:' => 'gzip' }})
    $responseCode=response.code
end


Then /^validate weather forecast service throw error with header Encoding$/ do
    $responseCode.should == 500
end


When /^set header of the weather forecast service to charset for city "([^"]*)" in "([^"]*)"$/ do | city, country|
    url="http://127.0.0.1:6001/getWeatherForcast?city=#{city}&country=#{country}"
    response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Accept-Charset:' => ' utf-8' }})
    $responseCode=response.code
end


When /^change the method type to "([^"]*)" for city "([^"]*)", country "([^"]*)" and expect server to throw error$/ do |methodType, city, country|
    url="http://127.0.0.1:6001/getWeatherForcast?city=#{city}&country=#{country}"
    
    case methodType.downcase

    when "get"
        puts "Executing for methodType"
        response=HTTParty.get(url, {:headers => { 'Content-Type' => 'application/json'}})
        response.code.should == 404
    when "put"
        puts "Executing for methodType"
        response=HTTParty.put(url, {:body => { "city" => city, "country" => country },:headers => {'Content-Type' => 'application/json'}})
        response.code.should == 404

    when "delete"
        puts "Executing for methodType"
        response=HTTParty.put(url, :headers => {'Content-Type' => 'application/json'})
        response.code.should == 404

    end
end

Then /^get temperature for without sending city name and country$/ do 
    url="http://127.0.0.1:6001/getWeatherForcast"
    puts url
    response=HTTParty.post(url, {:headers => { 'Content-Type' => 'application/json' }})
    $responseCode=response.code
end 

When /^set request content type to form-url-encoding for city "([^"]*)", country "([^"]*)"$/ do |city, country|
    encoded_url="http://127.0.0.1:6001/getWeatherForcast"
    response=HTTParty.post(encoded_url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/x-www-form-urlencoded' }})
    $responseCode=response.code
    body = JSON.parse(response.body)
    $responseBody=body
end


When /^pass invalid city as "([^"]*)" and country as "([^"]*)"$/ do |city, country|
    url="http://127.0.0.1:6001/getWeatherForcast?city=#{city}&country=#{country}"
    response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/json' }})
    $responseCode=response.code
end


Then /^validate API throw error for unknown city$/ do
    $responseCode.should == 500
end


When /^send the city name whose length is more then the service can support$/ do
    city="asdfghjkllqwertyuiopzxcvbnmqwertyuiopasdfghjklzxcvbnmcnbfdklldvhllddwhqll"
    country="mnbvcxzlkjhgfddasqewtrytuyoupmnbbcvxczalskdjhfghqpowierutyifdjbbdfewfu"
    url="http://127.0.0.1:6001/getWeatherForcast?city=#{city}&country=#{country}"
    response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/json' }})
    $responseCode=response.code
end


When /^(\d+) users use the service for city "([^"]*)", country "([^"]*)" immediately one after the another$/ do |count,city,country|
    $TotalUsers=count
    $executionTime=Array.new(count.to_i)
    url="http://127.0.0.1:6001/getWeatherForcast?city=#{city}&country=#{country}"
    response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/json' }})
    for i in 1..count.to_i
    start=Time.now
    response=HTTParty.post(url, {:body => { "city" => city, "country" => country },:headers => { 'Content-Type' => 'application/json' }})
    endTIme=Time.now
    response.code.should==200
    response["current"].should_not be_nil
    difference=(endTIme-start)
    $executionTime[i-1]=difference
    end
end


Then /^validate the execution time for all the users is not more then 4 seconds$/ do
    for i in 1..$TotalUsers.to_i
    puts "Response time of USER #{i} is #{$executionTime[i-1]}"
    $executionTime[i-1] < 4
  end
end