require 'HTTParty'

Then /^complete the test$/ do
	puts "completed"
end


Given /^I start the service$/ do 
	path = File.expand_path File.dirname(__FILE__) 
	command = "ruby #{path}/../support/actions.rb"
	puts command 
	$pid  = spawn(command)
	Process.detach($pid)
	sleep(3)
	
end


Then /^get temperature for city "([^"]*)" of country "([^"]*)"$/ do |city, country|
	puts city
	puts country
	url="http://127.0.0.1:6001/getWeatherForcast?city=#{city}&country=#{country}"
	response=HTTParty.post(url, { 
                :body => { "city" => city, "country" => country },
                :headers => { 'Content-Type' => 'application/json' }
               })

	body = JSON.parse(response.body)
	puts "Server Response is: #{body}"	
	response.code.should== 200

	body.should_not be_nil
	body["city"].should ==city
	body["country"].should ==country
	body["current"].should_not be_nil

	puts "Temperature of #{city} is #{body["current"]}"
end

Then /^get temperature by passing invalid city "([^"]*)" of country "([^"]*)"$/ do |city, country|
	puts "city: #{city}"
	puts "country #{country}"
	url="http://127.0.0.1:6001/getWeatherForcast?city=#{city}&country=#{country}"
	response=HTTParty.post(url, { 
                :body => { "city" => city, "country" => country },
                :headers => { 'Content-Type' => 'application/json' }
               })

	response.code.should == 500
end


And /^i stop the service$/ do
	puts "my process = #{$pid}"
	begin
        status = Process.kill('TERM', $pid)
        status.should ==1
        puts "process was killed = #{status}"
        # Process.wait
    rescue => ex
        puts "ERROR: Couldn't kill #{$pid}. #{ex.class}=#{ex.message}"
        raise Exception "Couldn't kill #{$pid}"
    end
end


And /^the service is down$/ do
	puts "service is down"
end

Then /^the test fail$/ do
	puts "This scenario failed as expected"
end



And /^i try to get temperature of "([^"]*)", "([^"]*)" but expect it to fail$/ do |city, country|
	puts city
	puts country
	url="http://127.0.0.1:6001/getWeatherForcast?city=#{city}&country=#{country}"
	begin
	response=HTTParty.post(url, { 
                :body => { "city" => city, "country" => country },
                :headers => { 'Content-Type' => 'application/json' }
               })
	rescue  Errno::ECONNRESET 	=> ex
		raise "Could not connect to the server #{ex.message}"
		fail
	end
end

And /^test fail as service is down$/ do
	puts "test failed"
end


	
